from __future__ import annotations

import argparse
import json
from collections.abc import Iterator
from pathlib import Path
from typing import Any

import nbtlib
import pandas as pd


STATS_PATH = ("data", "contents", "stats")
KITS_PATH = (*STATS_PATH, "kits_dict")
SCHEMA_VERSION_PATH = (*STATS_PATH, "schema_version")
ABILITY_METADATA_PATH = (*STATS_PATH, "ability_metadata")
DAMAGE_CAUSE_NAMES_PATH = (*STATS_PATH, "damage_cause_names")
ELO_METADATA_PATH = (*STATS_PATH, "elo_metadata")
ELO_RATINGS_PATH = (*STATS_PATH, "elo_ratings")
SUPPORTED_SCHEMA_VERSION = 4
DAMAGE_TENTHS_PER_HEART = 10


def get_nbt_path(nbt_file: nbtlib.File, path: tuple[str, ...]) -> Any:
    """Return a value from command_storage.dat at the given NBT path."""
    try:
        value = nbt_file

        for key in path:
            value = value[key]

        return value

    except KeyError as exc:
        dotted_path = ".".join(path)
        raise RuntimeError(
            f"Could not find the expected NBT path: {dotted_path}\n"
            "Check that this is the correct command_storage.dat file."
        ) from exc


def get_kits_dict(nbt_file: nbtlib.File) -> Any:
    """Return the per-player kit statistics from command_storage.dat."""
    return get_nbt_path(nbt_file, KITS_PATH)


def get_schema_version(nbt_file: nbtlib.File) -> int:
    """Return and validate the statistics schema version."""
    schema_version = int(get_nbt_path(nbt_file, SCHEMA_VERSION_PATH))

    if schema_version != SUPPORTED_SCHEMA_VERSION:
        raise RuntimeError(
            f"Unsupported stats schema version {schema_version}; "
            f"this extractor supports version {SUPPORTED_SCHEMA_VERSION}."
        )

    return schema_version


def get_ability_metadata(nbt_file: nbtlib.File) -> Any:
    """Return the authoritative ability and metric metadata."""
    return get_nbt_path(nbt_file, ABILITY_METADATA_PATH)


def get_damage_cause_names(nbt_file: nbtlib.File) -> Any:
    """Return the shared damage-cause names from command_storage.dat."""
    return get_nbt_path(nbt_file, DAMAGE_CAUSE_NAMES_PATH)


def get_elo_metadata(nbt_file: nbtlib.File) -> Any:
    """Return the authoritative Elo configuration and metric metadata."""
    return get_nbt_path(nbt_file, ELO_METADATA_PATH)


def get_elo_ratings(nbt_file: nbtlib.File) -> Any:
    """Return the current player-level Elo ratings."""
    return get_nbt_path(nbt_file, ELO_RATINGS_PATH)


def extract_kills(kits_dict: Any) -> pd.DataFrame:
    """
    Extract kill statistics.

    Columns:
        id_killer
        kit_id_killer
        kit_id_victim
        cause_id
        kills
    """
    rows: list[dict[str, Any]] = []

    for id_killer, player_data in kits_dict.items():
        for kit_id_killer, kit_data in player_data.items():
            kills_data = kit_data.get("kills", {})

            for kit_id_victim, causes_data in kills_data.items():
                if not hasattr(causes_data, "items"):
                    raise ValueError(
                        "Expected nested kill causes at "
                        f"kits_dict.{id_killer}.{kit_id_killer}.kills."
                        f"{kit_id_victim}"
                    )

                for cause_id, kill_count in causes_data.items():
                    rows.append(
                        {
                            "id_killer": str(id_killer),
                            "kit_id_killer": int(kit_id_killer),
                            "kit_id_victim": int(kit_id_victim),
                            "cause_id": int(cause_id),
                            "kills": int(kill_count),
                        }
                    )

    return pd.DataFrame(
        rows,
        columns=[
            "id_killer",
            "kit_id_killer",
            "kit_id_victim",
            "cause_id",
            "kills",
        ],
    )


def iter_damage_received(kits_dict: Any) -> Iterator[dict[str, Any]]:
    """Yield raw cumulative damage rows, retaining tenths-of-a-heart values."""
    for id_target, player_data in kits_dict.items():
        for kit_id_target, kit_data in player_data.items():
            damage_data = kit_data.get("damage_received", {})

            if not hasattr(damage_data, "items"):
                raise ValueError(
                    "Expected damage sources at "
                    f"kits_dict.{id_target}.{kit_id_target}.damage_received"
                )

            for id_source, source_player_data in damage_data.items():
                if not hasattr(source_player_data, "items"):
                    raise ValueError(
                        "Expected source kits at "
                        f"kits_dict.{id_target}.{kit_id_target}.damage_received."
                        f"{id_source}"
                    )

                for kit_id_source, causes_data in source_player_data.items():
                    if not hasattr(causes_data, "items"):
                        raise ValueError(
                            "Expected nested damage causes at "
                            f"kits_dict.{id_target}.{kit_id_target}."
                            f"damage_received.{id_source}.{kit_id_source}"
                        )

                    for cause_id, damage_tenths in causes_data.items():
                        yield {
                            "id_target": str(id_target),
                            "kit_id_target": int(kit_id_target),
                            "id_source": str(id_source),
                            "kit_id_source": int(kit_id_source),
                            "cause_id": int(cause_id),
                            "damage_tenths": int(damage_tenths),
                        }


def extract_damage_received(
    damage_rows: list[dict[str, Any]],
) -> pd.DataFrame:
    """
    Extract cumulative damage received statistics.

    Columns:
        id_target
        kit_id_target
        id_source
        kit_id_source
        cause_id
        damage_received

    The stored values are integer tenths of a heart. They are converted to
    hearts here.
    """
    rows = [
        {
            "id_target": row["id_target"],
            "kit_id_target": row["kit_id_target"],
            "id_source": row["id_source"],
            "kit_id_source": row["kit_id_source"],
            "cause_id": row["cause_id"],
            "damage_received": (
                row["damage_tenths"] / DAMAGE_TENTHS_PER_HEART
            ),
        }
        for row in damage_rows
    ]

    return pd.DataFrame(
        rows,
        columns=[
            "id_target",
            "kit_id_target",
            "id_source",
            "kit_id_source",
            "cause_id",
            "damage_received",
        ],
    )


def iter_metric_metadata(
    ability_metadata: Any,
) -> Iterator[tuple[int, str, str, Any, Any]]:
    """Yield kit, ability, metric, ability metadata, and metric metadata."""
    if not hasattr(ability_metadata, "items"):
        raise ValueError("Expected ability_metadata to be a compound")

    for kit_id, kit_metadata in ability_metadata.items():
        if not hasattr(kit_metadata, "items"):
            raise ValueError(f"Expected abilities at ability_metadata.{kit_id}")

        for ability_path, ability_data in kit_metadata.items():
            if not hasattr(ability_data, "items"):
                raise ValueError(
                    "Expected an ability compound at "
                    f"ability_metadata.{kit_id}.{ability_path}"
                )

            metrics = ability_data.get("metrics")
            if not hasattr(metrics, "items"):
                raise ValueError(
                    "Expected metric definitions at "
                    f"ability_metadata.{kit_id}.{ability_path}.metrics"
                )

            for metric_id, metric_data in metrics.items():
                if not hasattr(metric_data, "items"):
                    raise ValueError(
                        "Expected a metric compound at "
                        f"ability_metadata.{kit_id}.{ability_path}.metrics."
                        f"{metric_id}"
                    )

                yield (
                    int(kit_id),
                    str(ability_path),
                    str(metric_id),
                    ability_data,
                    metric_data,
                )


def metric_display_scale(metric_data: Any, metric_path: str) -> float:
    """Return a metric's raw-to-display multiplier."""
    if "display_scale" not in metric_data:
        raise ValueError(f"Missing display_scale at {metric_path}")

    return float(metric_data["display_scale"])


def extract_abilities(
    kits_dict: Any,
    ability_metadata: Any,
    damage_rows: list[dict[str, Any]],
) -> pd.DataFrame:
    """
    Extract stored and metadata-defined derived ability metrics.

    Columns:
        id
        kit_id
        ability_path
        metric_id
        value

    ``value`` is multiplied by the metric's ``display_scale`` and is therefore
    expressed in its ``display_unit`` (for example uses, seconds, blocks, or
    hearts). Missing lazy fields remain absent rather than becoming zero rows.
    """
    rows: list[dict[str, Any]] = []
    stored_metrics: dict[tuple[int, str, str], tuple[str, float]] = {}
    derived_metrics: list[tuple[int, str, str, Any, float]] = []

    for (
        kit_id,
        ability_path,
        metric_id,
        _ability_data,
        metric_data,
    ) in iter_metric_metadata(ability_metadata):
        metric_path = (
            f"ability_metadata.{kit_id}.{ability_path}.metrics.{metric_id}"
        )
        source = metric_data.get("source")

        if not hasattr(source, "items") or "type" not in source:
            raise ValueError(f"Missing metric source at {metric_path}.source")

        source_type = str(source["type"])
        display_scale = metric_display_scale(metric_data, metric_path)

        if source_type == "ability_field":
            if "field" not in source:
                raise ValueError(f"Missing field at {metric_path}.source")

            field = str(source["field"])
            lookup_key = (kit_id, ability_path, field)

            if lookup_key in stored_metrics:
                other_metric_id, _ = stored_metrics[lookup_key]
                raise ValueError(
                    f"Metrics {other_metric_id!r} and {metric_id!r} both "
                    f"reference {kit_id}.{ability_path}.{field}"
                )

            stored_metrics[lookup_key] = (metric_id, display_scale)

        elif source_type == "damage_received":
            derived_metrics.append(
                (kit_id, ability_path, metric_id, source, display_scale)
            )

        else:
            raise ValueError(
                f"Unsupported metric source type {source_type!r} at "
                f"{metric_path}.source.type"
            )

    for player_id, player_data in kits_dict.items():
        for kit_id, kit_data in player_data.items():
            abilities_data = kit_data.get("abilities", {})

            if not hasattr(abilities_data, "items"):
                raise ValueError(
                    f"Expected abilities at kits_dict.{player_id}.{kit_id}.abilities"
                )

            for ability_path, metric_values in abilities_data.items():
                if not hasattr(metric_values, "items"):
                    raise ValueError(
                        "Expected ability metrics at "
                        f"kits_dict.{player_id}.{kit_id}.abilities.{ability_path}"
                    )

                for field, stored_value in metric_values.items():
                    lookup_key = (int(kit_id), str(ability_path), str(field))

                    if lookup_key not in stored_metrics:
                        raise ValueError(
                            "No ability_field metadata describes "
                            f"kits_dict.{player_id}.{kit_id}.abilities."
                            f"{ability_path}.{field}"
                        )

                    metric_id, display_scale = stored_metrics[lookup_key]
                    rows.append(
                        {
                            "id": str(player_id),
                            "kit_id": int(kit_id),
                            "ability_path": str(ability_path),
                            "metric_id": metric_id,
                            "value": int(stored_value) * display_scale,
                        }
                    )

    for (
        kit_id,
        ability_path,
        metric_id,
        source,
        display_scale,
    ) in derived_metrics:
        metric_path = (
            f"ability_metadata.{kit_id}.{ability_path}.metrics.{metric_id}.source"
        )

        if "source_kit_id" not in source or "cause_ids" not in source:
            raise ValueError(
                f"Missing source_kit_id or cause_ids at {metric_path}"
            )

        source_kit_id = int(source["source_kit_id"])
        cause_ids = {int(cause_id) for cause_id in source["cause_ids"]}
        exclude_self = bool(int(source.get("exclude_self", 0)))
        totals_by_source: dict[str, int] = {}

        for damage_row in damage_rows:
            if damage_row["kit_id_source"] != source_kit_id:
                continue
            if damage_row["cause_id"] not in cause_ids:
                continue
            if (
                exclude_self
                and damage_row["id_source"] == damage_row["id_target"]
            ):
                continue

            source_id = damage_row["id_source"]
            totals_by_source[source_id] = (
                totals_by_source.get(source_id, 0)
                + damage_row["damage_tenths"]
            )

        for source_id, stored_value in totals_by_source.items():
            rows.append(
                {
                    "id": source_id,
                    "kit_id": kit_id,
                    "ability_path": ability_path,
                    "metric_id": metric_id,
                    "value": stored_value * display_scale,
                }
            )

    return pd.DataFrame(
        rows,
        columns=[
            "id",
            "kit_id",
            "ability_path",
            "metric_id",
            "value",
        ],
    )


def extract_picks(kits_dict: Any) -> pd.DataFrame:
    """
    Extract kit pick statistics.

    Columns:
        id
        kit_id
        total_time
        nbr_picks

    Player IDs are kept as strings. Kit IDs are integers, including the ``-1``
    sentinel used for no kit.
    """
    rows: list[dict[str, Any]] = []

    for player_id, player_data in kits_dict.items():
        for kit_id, kit_data in player_data.items():
            if "pick" not in kit_data:
                continue

            pick_data = kit_data["pick"]
            rows.append(
                {
                    "id": str(player_id),
                    "kit_id": int(kit_id),
                    "total_time": int(pick_data["total_time"]),
                    "nbr_picks": int(pick_data["nbr_picks"]),
                }
            )

    return pd.DataFrame(
        rows,
        columns=[
            "id",
            "kit_id",
            "total_time",
            "nbr_picks",
        ],
    )


def nbt_to_python(value: Any) -> Any:
    """Recursively convert an NBT value into JSON-compatible Python values."""
    unpack = getattr(value, "unpack", None)
    return unpack() if callable(unpack) else value


def extract_ability_metadata(ability_metadata: Any) -> pd.DataFrame:
    """
    Extract one metadata row per ability metric.

    Columns:
        kit_id
        ability_path
        metric_id
        metric_name
        description
        cooldown_ticks
        duration_ticks
        settings_json
        stored_unit
        display_unit
        display_scale
        source_type
        source_field
        source_kit_id
        source_cause_ids
        source_exclude_self
    """
    rows: list[dict[str, Any]] = []

    for (
        kit_id,
        ability_path,
        metric_id,
        ability_data,
        metric_data,
    ) in iter_metric_metadata(ability_metadata):
        metric_path = (
            f"ability_metadata.{kit_id}.{ability_path}.metrics.{metric_id}"
        )
        source = metric_data.get("source")

        if not hasattr(source, "items") or "type" not in source:
            raise ValueError(f"Missing metric source at {metric_path}.source")

        settings = ability_data.get("settings")
        rows.append(
            {
                "kit_id": kit_id,
                "ability_path": ability_path,
                "metric_id": metric_id,
                "metric_name": str(metric_data.get("name", metric_id)),
                "description": str(metric_data.get("description", "")),
                "cooldown_ticks": (
                    int(ability_data["cooldown"])
                    if "cooldown" in ability_data
                    else None
                ),
                "duration_ticks": (
                    int(ability_data["duration"])
                    if "duration" in ability_data
                    else None
                ),
                "settings_json": (
                    json.dumps(
                        nbt_to_python(settings),
                        ensure_ascii=False,
                        sort_keys=True,
                        separators=(",", ":"),
                    )
                    if settings is not None
                    else None
                ),
                "stored_unit": str(metric_data.get("stored_unit", "")),
                "display_unit": str(metric_data.get("display_unit", "")),
                "display_scale": metric_display_scale(
                    metric_data,
                    metric_path,
                ),
                "source_type": str(source["type"]),
                "source_field": (
                    str(source["field"]) if "field" in source else None
                ),
                "source_kit_id": (
                    int(source["source_kit_id"])
                    if "source_kit_id" in source
                    else None
                ),
                "source_cause_ids": (
                    [int(cause_id) for cause_id in source["cause_ids"]]
                    if "cause_ids" in source
                    else None
                ),
                "source_exclude_self": (
                    bool(int(source["exclude_self"]))
                    if "exclude_self" in source
                    else None
                ),
            }
        )

    result = pd.DataFrame(
        rows,
        columns=[
            "kit_id",
            "ability_path",
            "metric_id",
            "metric_name",
            "description",
            "cooldown_ticks",
            "duration_ticks",
            "settings_json",
            "stored_unit",
            "display_unit",
            "display_scale",
            "source_type",
            "source_field",
            "source_kit_id",
            "source_cause_ids",
            "source_exclude_self",
        ],
    )

    if not result.empty:
        result["cooldown_ticks"] = result["cooldown_ticks"].astype("Int64")
        result["duration_ticks"] = result["duration_ticks"].astype("Int64")
        result["source_kit_id"] = result["source_kit_id"].astype("Int64")
        result["source_exclude_self"] = result[
            "source_exclude_self"
        ].astype("boolean")

    return result.sort_values(
        ["kit_id", "ability_path", "metric_id"]
    ).reset_index(drop=True)


def extract_damage_causes(damage_cause_names: Any) -> pd.DataFrame:
    """
    Extract the shared damage-cause metadata.

    Columns:
        cause_id
        cause_name
    """
    rows = [
        {
            "cause_id": int(cause_id),
            "cause_name": str(cause_name),
        }
        for cause_id, cause_name in damage_cause_names.items()
    ]

    return (
        pd.DataFrame(
            rows,
            columns=[
                "cause_id",
                "cause_name",
            ],
        )
        .sort_values("cause_id")
        .reset_index(drop=True)
    )


def get_elo_metric_definitions(elo_metadata: Any) -> Any:
    """Return and validate the Elo metric-definition compound."""
    if not hasattr(elo_metadata, "items"):
        raise ValueError("Expected elo_metadata to be a compound")

    metrics = elo_metadata.get("metrics")

    if not hasattr(metrics, "items"):
        raise ValueError("Expected metric definitions at elo_metadata.metrics")

    return metrics


def extract_elo_metadata(elo_metadata: Any) -> pd.DataFrame:
    """
    Extract Elo configuration and metric definitions.

    One row is emitted per metric.

    Columns:
        elo_name
        elo_description
        algorithm
        initial_rating
        k_factor
        rating_divisor
        result_type
        major_events_rated
        environmental_deaths_rated
        self_kills_rated
        update_mode
        metric_id
        metric_name
        metric_description
        stored_unit
        display_unit
        display_scale
    """
    metrics = get_elo_metric_definitions(elo_metadata)
    required_configuration = [
        "name",
        "description",
        "algorithm",
        "initial_rating",
        "k_factor",
        "rating_divisor",
        "result_type",
        "major_events_rated",
        "environmental_deaths_rated",
        "self_kills_rated",
        "update_mode",
    ]
    missing_configuration = [
        field for field in required_configuration if field not in elo_metadata
    ]

    if missing_configuration:
        raise ValueError(
            "Missing Elo metadata field(s): "
            + ", ".join(missing_configuration)
        )

    rows: list[dict[str, Any]] = []

    for metric_id, metric_data in metrics.items():
        metric_path = f"elo_metadata.metrics.{metric_id}"

        if not hasattr(metric_data, "items"):
            raise ValueError(f"Expected a metric compound at {metric_path}")

        missing_metric_fields = [
            field
            for field in [
                "name",
                "description",
                "stored_unit",
                "display_unit",
                "display_scale",
            ]
            if field not in metric_data
        ]

        if missing_metric_fields:
            raise ValueError(
                f"Missing field(s) at {metric_path}: "
                + ", ".join(missing_metric_fields)
            )

        rows.append(
            {
                "elo_name": str(elo_metadata["name"]),
                "elo_description": str(elo_metadata["description"]),
                "algorithm": str(elo_metadata["algorithm"]),
                "initial_rating": float(elo_metadata["initial_rating"]),
                "k_factor": float(elo_metadata["k_factor"]),
                "rating_divisor": float(elo_metadata["rating_divisor"]),
                "result_type": str(elo_metadata["result_type"]),
                "major_events_rated": bool(
                    int(elo_metadata["major_events_rated"])
                ),
                "environmental_deaths_rated": bool(
                    int(elo_metadata["environmental_deaths_rated"])
                ),
                "self_kills_rated": bool(
                    int(elo_metadata["self_kills_rated"])
                ),
                "update_mode": str(elo_metadata["update_mode"]),
                "metric_id": str(metric_id),
                "metric_name": str(metric_data["name"]),
                "metric_description": str(metric_data["description"]),
                "stored_unit": str(metric_data["stored_unit"]),
                "display_unit": str(metric_data["display_unit"]),
                "display_scale": metric_display_scale(
                    metric_data,
                    metric_path,
                ),
            }
        )

    return (
        pd.DataFrame(
            rows,
            columns=[
                "elo_name",
                "elo_description",
                "algorithm",
                "initial_rating",
                "k_factor",
                "rating_divisor",
                "result_type",
                "major_events_rated",
                "environmental_deaths_rated",
                "self_kills_rated",
                "update_mode",
                "metric_id",
                "metric_name",
                "metric_description",
                "stored_unit",
                "display_unit",
                "display_scale",
            ],
        )
        .sort_values("metric_id")
        .reset_index(drop=True)
    )


def extract_elo_ratings(
    elo_ratings: Any,
    elo_metadata: Any,
) -> pd.DataFrame:
    """
    Extract the current player-level Elo snapshot.

    Columns:
        id
        rating
        rated_encounters

    ``rating`` is converted from its stored integer representation with the
    metadata-provided display scale. ``rated_encounters`` remains an integer
    count.
    """
    if not hasattr(elo_ratings, "items"):
        raise ValueError("Expected elo_ratings to be a compound")

    metrics = get_elo_metric_definitions(elo_metadata)
    missing_metrics = [
        metric_id
        for metric_id in ["rating", "rated_encounters"]
        if metric_id not in metrics
    ]

    if missing_metrics:
        raise ValueError(
            "Missing Elo metric definition(s): " + ", ".join(missing_metrics)
        )

    rating_metric = metrics["rating"]
    encounters_metric = metrics["rated_encounters"]

    if not hasattr(rating_metric, "items"):
        raise ValueError(
            "Expected a metric compound at elo_metadata.metrics.rating"
        )
    if not hasattr(encounters_metric, "items"):
        raise ValueError(
            "Expected a metric compound at "
            "elo_metadata.metrics.rated_encounters"
        )

    rating_scale = metric_display_scale(
        rating_metric,
        "elo_metadata.metrics.rating",
    )
    encounters_scale = metric_display_scale(
        encounters_metric,
        "elo_metadata.metrics.rated_encounters",
    )

    if encounters_scale != 1.0:
        raise ValueError(
            "elo_metadata.metrics.rated_encounters.display_scale must be 1"
        )

    rows: list[dict[str, Any]] = []

    for player_id, rating_data in elo_ratings.items():
        rating_path = f"elo_ratings.{player_id}"

        if not hasattr(rating_data, "items"):
            raise ValueError(f"Expected a rating compound at {rating_path}")

        missing_fields = [
            field
            for field in ["rating", "rated_encounters"]
            if field not in rating_data
        ]

        if missing_fields:
            raise ValueError(
                f"Missing field(s) at {rating_path}: "
                + ", ".join(missing_fields)
            )

        rows.append(
            {
                "id": str(player_id),
                "rating": int(rating_data["rating"]) * rating_scale,
                "rated_encounters": int(rating_data["rated_encounters"]),
            }
        )

    return pd.DataFrame(
        rows,
        columns=[
            "id",
            "rating",
            "rated_encounters",
        ],
    )


def extract(input_path: Path, output_dir: Path) -> None:
    """Extract statistics from command_storage.dat into Parquet files."""
    print(f"Reading {input_path}")

    nbt_file = nbtlib.load(input_path)
    schema_version = get_schema_version(nbt_file)
    kits_dict = get_kits_dict(nbt_file)
    ability_metadata = get_ability_metadata(nbt_file)
    damage_cause_names = get_damage_cause_names(nbt_file)
    elo_metadata = get_elo_metadata(nbt_file)
    elo_ratings = get_elo_ratings(nbt_file)
    damage_rows = list(iter_damage_received(kits_dict))

    kills = extract_kills(kits_dict)
    damage_received = extract_damage_received(damage_rows)
    abilities = extract_abilities(
        kits_dict,
        ability_metadata,
        damage_rows,
    )
    picks = extract_picks(kits_dict)
    extracted_ability_metadata = extract_ability_metadata(ability_metadata)
    damage_causes = extract_damage_causes(damage_cause_names)
    extracted_elo_metadata = extract_elo_metadata(elo_metadata)
    extracted_elo_ratings = extract_elo_ratings(
        elo_ratings,
        elo_metadata,
    )

    output_dir.mkdir(parents=True, exist_ok=True)

    obsolete_elo_event_path = output_dir / "elo_event.parquet"
    if obsolete_elo_event_path.exists():
        obsolete_elo_event_path.unlink()
        print(f"Removed obsolete output: {obsolete_elo_event_path}")

    kills_path = output_dir / "kills.parquet"
    damage_received_path = output_dir / "damage_received.parquet"
    abilities_path = output_dir / "abilities.parquet"
    picks_path = output_dir / "picks.parquet"
    ability_metadata_path = output_dir / "ability_metadata.parquet"
    damage_causes_path = output_dir / "damage_causes.parquet"
    elo_metadata_path = output_dir / "elo_metadata.parquet"
    elo_ratings_path = output_dir / "elo_ratings.parquet"

    kills.to_parquet(kills_path, index=False)
    damage_received.to_parquet(damage_received_path, index=False)
    abilities.to_parquet(abilities_path, index=False)
    picks.to_parquet(picks_path, index=False)
    extracted_ability_metadata.to_parquet(ability_metadata_path, index=False)
    damage_causes.to_parquet(damage_causes_path, index=False)
    extracted_elo_metadata.to_parquet(elo_metadata_path, index=False)
    extracted_elo_ratings.to_parquet(elo_ratings_path, index=False)

    print(f"Schema:     {schema_version}")
    print(f"Kills:      {len(kills):,} rows -> {kills_path}")
    print(
        f"Damage:     {len(damage_received):,} rows -> {damage_received_path}"
    )
    print(f"Abilities:  {len(abilities):,} rows -> {abilities_path}")
    print(f"Picks:      {len(picks):,} rows -> {picks_path}")
    print(
        "Ability metadata: "
        f"{len(extracted_ability_metadata):,} rows -> {ability_metadata_path}"
    )
    print(f"Causes:     {len(damage_causes):,} rows -> {damage_causes_path}")
    print(
        "Elo metadata: "
        f"{len(extracted_elo_metadata):,} rows -> {elo_metadata_path}"
    )
    print(
        f"Elo ratings: {len(extracted_elo_ratings):,} rows -> "
        f"{elo_ratings_path}"
    )


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Extract kit statistics from command_storage.dat."
    )

    parser.add_argument(
        "input",
        nargs="?",
        type=Path,
        default=Path("command_storage.dat"),
        help="Path to command_storage.dat",
    )

    parser.add_argument(
        "-o",
        "--output-dir",
        type=Path,
        default=Path("data"),
        help="Directory in which to write Parquet files",
    )

    args = parser.parse_args()

    extract(args.input, args.output_dir)


if __name__ == "__main__":
    main()

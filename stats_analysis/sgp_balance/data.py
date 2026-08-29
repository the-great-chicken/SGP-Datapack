"""Load, validate, and assemble the analysis-ready report data."""

from __future__ import annotations

from pathlib import Path
from typing import Sequence

import numpy as np
import pandas as pd

from .core import (
    ABILITY_COLUMNS,
    ABILITY_METADATA_COLUMNS,
    DAMAGE_CAUSE_COLUMNS,
    DAMAGE_COLUMNS,
    DEFAULT_TIME_UNITS_PER_HOUR,
    ELO_METADATA_COLUMNS,
    ELO_RATING_COLUMNS,
    KILL_COLUMNS,
    KIT_ID_TO_NAME,
    KIT_NAMES,
    MINECRAFT_TICKS_PER_HOUR,
    MINECRAFT_TICKS_PER_SECOND,
    NO_KIT_ID,
    NO_PLAYER_ID,
    PICK_COLUMNS,
    ReportData,
)
from .metrics_abilities import (
    _build_ability_tables,
    _build_kit_ability_settings,
)
from .metrics_combat import (
    _build_damage_cause_tables,
    _build_damage_tables,
    _build_elo_kill_context,
    _build_kill_tables,
    _build_kill_cause_tables,
    _build_kit_elo_context,
    _build_player_elo,
)
from .metrics_players import (
    _build_kit_exposure,
    _build_kit_metrics,
    _build_player_kit_exposure,
    _build_player_kit_metrics,
    _build_player_rate_stats,
    _build_reach,
    _build_top_killer_exposure,
)


def load_report_data(
    data_dir: str | Path = "data",
    *,
    time_units_per_hour: float = DEFAULT_TIME_UNITS_PER_HOUR,
) -> ReportData:
    """Load the normalized extracts and prepare shared report tables.

    ``time_units_per_hour`` defaults to 72,000, assuming ``total_time`` is
    measured in Minecraft ticks.  Override it if the datapack records a
    different unit (for example, use 3,600 when it records seconds).
    """

    data_dir = Path(data_dir)
    kills = pd.read_parquet(data_dir / "kills.parquet")
    damage_path = data_dir / "damage_received.parquet"
    damage_received = (
        pd.read_parquet(damage_path)
        if damage_path.exists()
        else pd.DataFrame(columns=DAMAGE_COLUMNS)
    )
    abilities = pd.read_parquet(data_dir / "abilities.parquet")
    picks = pd.read_parquet(data_dir / "picks.parquet")
    ability_metadata = pd.read_parquet(
        data_dir / "ability_metadata.parquet"
    )
    damage_causes_path = data_dir / "damage_causes.parquet"
    if not damage_causes_path.exists():
        damage_causes_path = data_dir / "kill_causes.parquet"
    damage_causes = pd.read_parquet(damage_causes_path)
    elo_metadata_path = data_dir / "elo_metadata.parquet"
    elo_ratings_path = data_dir / "elo_ratings.parquet"
    if elo_metadata_path.exists() != elo_ratings_path.exists():
        raise FileNotFoundError(
            "elo_metadata.parquet and elo_ratings.parquet must either both "
            "exist or both be absent"
        )
    if elo_metadata_path.exists():
        elo_metadata = pd.read_parquet(elo_metadata_path)
        elo_ratings = pd.read_parquet(elo_ratings_path)
    else:
        elo_metadata = pd.DataFrame(columns=ELO_METADATA_COLUMNS)
        elo_ratings = pd.DataFrame(columns=ELO_RATING_COLUMNS)
    return prepare_report_data(
        kills,
        abilities,
        picks,
        ability_metadata,
        damage_causes,
        damage_received=damage_received,
        elo_metadata=elo_metadata,
        elo_ratings=elo_ratings,
        time_units_per_hour=time_units_per_hour,
    )


def prepare_report_data(
    kills: pd.DataFrame,
    abilities: pd.DataFrame,
    picks: pd.DataFrame,
    ability_metadata: pd.DataFrame,
    kill_causes: pd.DataFrame,
    *,
    damage_received: pd.DataFrame | None = None,
    elo_metadata: pd.DataFrame | None = None,
    elo_ratings: pd.DataFrame | None = None,
    time_units_per_hour: float = DEFAULT_TIME_UNITS_PER_HOUR,
) -> ReportData:
    """Validate normalized inputs and derive analysis-ready datasets.

    ``ability_metadata`` supplies the canonical activation counter, success
    condition, optional effect metric, and timing for one ability per kit.
    ``elo_metadata`` and ``elo_ratings`` provide optional current player-skill
    context; when present they must be supplied together.
    ``kill_causes`` keeps the established public parameter name.  The new
    extract writes the same shared cause metadata to ``damage_causes.parquet``
    because it now describes both kill and damage rows.
    """

    if not np.isfinite(time_units_per_hour) or time_units_per_hour <= 0:
        raise ValueError("time_units_per_hour must be a positive finite value")

    if damage_received is None:
        damage_received = pd.DataFrame(columns=DAMAGE_COLUMNS)
    if (elo_metadata is None) != (elo_ratings is None):
        raise ValueError(
            "elo_metadata and elo_ratings must be provided together"
        )
    if elo_metadata is None:
        elo_metadata = pd.DataFrame(columns=ELO_METADATA_COLUMNS)
        elo_ratings = pd.DataFrame(columns=ELO_RATING_COLUMNS)
    assert elo_ratings is not None
    damage_causes = kill_causes

    (
        kills,
        damage_received,
        abilities,
        picks,
        ability_metadata,
        damage_causes,
    ) = (
        _validate_and_normalize(
            kills,
            damage_received,
            abilities,
            picks,
            ability_metadata,
            damage_causes,
        )
    )
    elo_metadata, elo_ratings = _validate_and_normalize_elo(
        elo_metadata,
        elo_ratings,
    )
    all_kits = pd.DataFrame(
        {
            "kit_id": list(KIT_ID_TO_NAME),
            "kit_name": list(KIT_ID_TO_NAME.values()),
        }
    )
    # Preserve sentinel rows in the validated extract, but keep established
    # player-kill metrics restricted to deaths where both kits are known.
    attributed_kills = kills.loc[
        kills["kit_id_killer"].isin(KIT_ID_TO_NAME)
        & kills["kit_id_victim"].isin(KIT_ID_TO_NAME)
    ].copy()
    kit_settings = _build_kit_ability_settings(
        ability_metadata,
        all_kits,
    )
    kit_settings["ability_cooldown_seconds"] = (
        kit_settings["ability_cooldown"] / MINECRAFT_TICKS_PER_SECOND
    )
    kit_settings["theoretical_ability_uses_per_hour"] = (
        MINECRAFT_TICKS_PER_HOUR / kit_settings["ability_cooldown"]
    )

    (
        player_kit_kills,
        total_kills_by_kit,
        kit_kill_stats,
        matchup_matrix,
        directional_share,
        pair_totals,
    ) = _build_kill_tables(attributed_kills, all_kits)

    # Offensive damage uses the same known-kit universe as attributed kills.
    # Incoming defensive metrics retain damage from unknown or non-player
    # sources as long as the target kit is known.
    attributed_damage = damage_received.loc[
        damage_received["kit_id_source"].isin(KIT_ID_TO_NAME)
        & damage_received["kit_id_target"].isin(KIT_ID_TO_NAME)
    ].copy()
    (
        player_kit_damage_dealt,
        total_damage_dealt_by_kit,
        kit_damage_dealt_stats,
        player_kit_damage_received,
        kit_damage_received_stats,
        damage_matchup_matrix,
        damage_directional_share,
        damage_pair_totals,
    ) = _build_damage_tables(
        damage_received,
        attributed_damage,
        all_kits,
    )

    (
        player_kit_abilities,
        total_abilities_by_kit,
        kit_ability_stats,
    ) = _build_ability_tables(
        abilities,
        all_kits,
        kit_settings,
    )

    damage_player_sources = damage_received.loc[
        damage_received["kit_id_source"].isin(KIT_ID_TO_NAME),
        "id_source",
    ]
    all_player_ids = (
        set(kills["id_killer"])
        | set(kills["id_victim"])
        | set(damage_received["id_target"])
        | set(damage_player_sources)
        | set(abilities["id"])
        | set(picks["id"])
    ) - {NO_PLAYER_ID}
    n_players = len(all_player_ids)
    player_elo = _build_player_elo(
        all_player_ids,
        elo_metadata,
        elo_ratings,
        kills,
    )
    (
        elo_kill_results,
        elo_matchup_expected_share,
        elo_matchup_score_difference,
        elo_matchup_pair_totals,
    ) = _build_elo_kill_context(
        attributed_kills,
        player_elo,
        elo_metadata,
        all_kits,
    )

    player_kit_exposure, no_kit_exposure = _build_player_kit_exposure(
        picks,
        time_units_per_hour=time_units_per_hour,
    )
    kit_exposure = _build_kit_exposure(
        player_kit_exposure,
        all_kits,
        n_players=n_players,
    )
    kit_elo_context = _build_kit_elo_context(
        player_kit_exposure,
        player_elo,
        all_kits,
    )
    (
        kill_causes,
        outgoing_kills_by_cause,
        incoming_deaths_by_cause,
        matchup_kills_by_cause,
        death_metrics,
    ) = _build_kill_cause_tables(
        kills,
        attributed_kills,
        all_kits,
        kit_exposure,
        damage_causes,
    )
    (
        damage_causes,
        outgoing_damage_by_cause,
        incoming_damage_by_cause,
        matchup_damage_by_cause,
        damage_metrics,
    ) = _build_damage_cause_tables(
        damage_received,
        attributed_damage,
        all_kits,
        kit_exposure,
        damage_causes,
    )
    player_kit_metrics = _build_player_kit_metrics(
        player_kit_exposure,
        player_kit_kills,
        player_kit_abilities,
        player_kit_damage_dealt,
        kit_settings,
        player_elo,
    )
    player_rate_stats = _build_player_rate_stats(
        player_kit_metrics,
        all_kits,
    )
    kit_metrics = _build_kit_metrics(
        all_kits,
        total_kills_by_kit,
        total_abilities_by_kit,
        kit_exposure,
        player_rate_stats,
        kit_settings,
        death_metrics,
        damage_metrics,
        kit_elo_context,
    )
    top_killer_exposure = _build_top_killer_exposure(
        player_kit_metrics,
        kit_metrics,
    )

    reach = _build_reach(
        player_kit_kills,
        player_kit_abilities,
        player_kit_exposure,
        n_players,
    )

    # Backward-compatible name used by the existing aggregate scatter plot.
    # It now also exposes all normalized metrics for future plots.
    combined_totals = kit_metrics.copy()

    summary = (
        kit_metrics.merge(
            kit_kill_stats[
                ["kit_id", "players", "top_player_share", "top_3_share"]
            ].rename(columns={"players": "players_with_kills"}),
            on="kit_id",
            how="left",
        )
        .merge(
            kit_ability_stats[
                [
                    "kit_id",
                    "players_using_ability",
                    "top_player_ability_share",
                    "top_3_ability_share",
                ]
            ],
            on="kit_id",
            how="left",
        )
        .merge(
            kit_damage_dealt_stats[
                [
                    "kit_id",
                    "players_dealing_damage",
                    "top_player_damage_share",
                    "top_3_damage_share",
                ]
            ],
            on="kit_id",
            how="left",
        )
        .merge(
            kit_damage_received_stats[
                [
                    "kit_id",
                    "players_receiving_damage",
                    "top_player_received_damage_share",
                    "top_3_received_damage_share",
                ]
            ],
            on="kit_id",
            how="left",
        )
        .merge(
            reach[
                [
                    "kit_name",
                    "played",
                    "made_kill",
                    "used_ability",
                    "played_count",
                    "made_kill_count",
                    "used_ability_count",
                ]
            ],
            on="kit_name",
            how="left",
        )
    )

    return ReportData(
        kills=kills,
        damage_received=damage_received,
        abilities=abilities,
        ability_metadata=ability_metadata,
        elo_metadata=elo_metadata,
        elo_ratings=elo_ratings,
        picks=picks,
        kit_settings=kit_settings,
        all_kits=all_kits,
        player_kit_kills=player_kit_kills,
        total_kills_by_kit=total_kills_by_kit,
        kit_kill_stats=kit_kill_stats,
        kill_causes=kill_causes,
        outgoing_kills_by_cause=outgoing_kills_by_cause,
        incoming_deaths_by_cause=incoming_deaths_by_cause,
        matchup_kills_by_cause=matchup_kills_by_cause,
        death_metrics=death_metrics,
        player_kit_damage_dealt=player_kit_damage_dealt,
        total_damage_dealt_by_kit=total_damage_dealt_by_kit,
        kit_damage_dealt_stats=kit_damage_dealt_stats,
        player_kit_damage_received=player_kit_damage_received,
        kit_damage_received_stats=kit_damage_received_stats,
        damage_causes=damage_causes,
        outgoing_damage_by_cause=outgoing_damage_by_cause,
        incoming_damage_by_cause=incoming_damage_by_cause,
        matchup_damage_by_cause=matchup_damage_by_cause,
        damage_metrics=damage_metrics,
        matchup_matrix=matchup_matrix,
        directional_share=directional_share,
        pair_totals=pair_totals,
        damage_matchup_matrix=damage_matchup_matrix,
        damage_directional_share=damage_directional_share,
        damage_pair_totals=damage_pair_totals,
        player_kit_abilities=player_kit_abilities,
        total_abilities_by_kit=total_abilities_by_kit,
        kit_ability_stats=kit_ability_stats,
        player_elo=player_elo,
        player_kit_exposure=player_kit_exposure,
        kit_exposure=kit_exposure,
        kit_elo_context=kit_elo_context,
        elo_kill_results=elo_kill_results,
        elo_matchup_expected_share=elo_matchup_expected_share,
        elo_matchup_score_difference=elo_matchup_score_difference,
        elo_matchup_pair_totals=elo_matchup_pair_totals,
        player_kit_metrics=player_kit_metrics,
        kit_metrics=kit_metrics,
        top_killer_exposure=top_killer_exposure,
        reach=reach,
        combined_totals=combined_totals,
        summary=summary,
        no_kit_exposure=no_kit_exposure,
        n_players=n_players,
        time_units_per_hour=float(time_units_per_hour),
    )


def _validate_and_normalize(
    kills: pd.DataFrame,
    damage_received: pd.DataFrame,
    abilities: pd.DataFrame,
    picks: pd.DataFrame,
    ability_metadata: pd.DataFrame,
    damage_causes: pd.DataFrame,
) -> tuple[
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
]:
    _require_columns(kills, KILL_COLUMNS, "kills")
    _require_columns(damage_received, DAMAGE_COLUMNS, "damage_received")
    _require_columns(abilities, ABILITY_COLUMNS, "abilities")
    _require_columns(picks, PICK_COLUMNS, "picks")
    _require_columns(
        ability_metadata,
        ABILITY_METADATA_COLUMNS,
        "ability_metadata",
    )
    _require_columns(
        damage_causes,
        DAMAGE_CAUSE_COLUMNS,
        "damage_causes",
    )

    kills = kills.copy()
    damage_received = damage_received.copy()
    abilities = abilities.copy()
    picks = picks.copy()
    ability_metadata = ability_metadata.copy()
    damage_causes = damage_causes.copy()
    for frame, columns, name in (
        (kills, KILL_COLUMNS, "kills"),
        (damage_received, DAMAGE_COLUMNS, "damage_received"),
        (abilities, ABILITY_COLUMNS, "abilities"),
        (picks, PICK_COLUMNS, "picks"),
        (damage_causes, DAMAGE_CAUSE_COLUMNS, "damage_causes"),
    ):
        if frame[list(columns)].isna().any().any():
            raise ValueError(f"{name} contains missing values")

    kills["id_killer"] = kills["id_killer"].astype(str)
    kills["id_victim"] = kills["id_victim"].astype(str)
    for column in ("kit_id_killer", "kit_id_victim", "cause_id", "kills"):
        kills[column] = pd.to_numeric(kills[column], errors="raise").astype(int)

    damage_received["id_target"] = damage_received["id_target"].astype(str)
    damage_received["id_source"] = damage_received["id_source"].astype(str)
    for column in ("kit_id_target", "kit_id_source", "cause_id"):
        damage_received[column] = pd.to_numeric(
            damage_received[column], errors="raise"
        ).astype(int)
    damage_received["damage_received"] = pd.to_numeric(
        damage_received["damage_received"], errors="raise"
    ).astype(float)

    abilities["id"] = abilities["id"].astype(str)
    abilities["kit_id"] = pd.to_numeric(
        abilities["kit_id"], errors="raise"
    ).astype(int)
    abilities["ability_path"] = abilities["ability_path"].astype(str)
    abilities["metric_id"] = abilities["metric_id"].astype(str)
    abilities["value"] = pd.to_numeric(
        abilities["value"], errors="raise"
    ).astype(float)

    picks["id"] = picks["id"].astype(str)
    for column in ("kit_id", "total_time", "nbr_picks"):
        picks[column] = pd.to_numeric(picks[column], errors="raise").astype(int)

    ability_metadata["kit_id"] = pd.to_numeric(
        ability_metadata["kit_id"], errors="raise"
    ).astype(int)
    for column in (
        "ability_path",
        "metric_id",
        "metric_name",
        "description",
        "stored_unit",
        "display_unit",
        "source_type",
    ):
        ability_metadata[column] = ability_metadata[column].astype(str)
    for column in ("cooldown_ticks", "duration_ticks", "source_kit_id"):
        ability_metadata[column] = pd.to_numeric(
            ability_metadata[column], errors="coerce"
        ).astype("Int64")
    ability_metadata["display_scale"] = pd.to_numeric(
        ability_metadata["display_scale"], errors="raise"
    ).astype(float)
    ability_metadata["source_exclude_self"] = ability_metadata[
        "source_exclude_self"
    ].astype("boolean")

    damage_causes["cause_id"] = pd.to_numeric(
        damage_causes["cause_id"], errors="raise"
    ).astype(int)
    damage_causes["cause_name"] = damage_causes["cause_name"].astype(str)

    if (kills["kills"] < 0).any():
        raise ValueError("Negative kill count found")
    if (kills["cause_id"] < 0).any():
        raise ValueError("Negative kill-cause ID found")
    if not np.isfinite(damage_received["damage_received"]).all():
        raise ValueError("Non-finite damage value found")
    if (damage_received["damage_received"] < 0).any():
        raise ValueError("Negative damage value found")
    if (damage_received["cause_id"] < 0).any():
        raise ValueError("Negative damage-cause ID found")
    if (damage_causes["cause_id"] < 0).any():
        raise ValueError("Negative damage-cause metadata ID found")
    if damage_causes["cause_name"].str.strip().eq("").any():
        raise ValueError("Blank damage-cause name found")
    if not np.isfinite(abilities["value"]).all():
        raise ValueError("Non-finite ability metric value found")
    if (abilities["value"] < 0).any():
        raise ValueError("Negative ability metric value found")
    if (picks["total_time"] < 0).any():
        raise ValueError("Negative total_time found")
    if (picks["nbr_picks"] < 0).any():
        raise ValueError("Negative nbr_picks found")
    if not np.isfinite(ability_metadata["display_scale"]).all():
        raise ValueError("Non-finite ability display scale found")
    if (ability_metadata["display_scale"] <= 0).any():
        raise ValueError("Ability display scales must be positive")
    if ability_metadata["cooldown_ticks"].isna().any() or (
        ability_metadata["cooldown_ticks"] <= 0
    ).any():
        raise ValueError("Ability cooldowns must be present and positive")
    valid_kill_kit_ids = set(KIT_ID_TO_NAME) | {NO_KIT_ID}
    if not kills["kit_id_killer"].isin(valid_kill_kit_ids).all():
        raise ValueError("Unknown killer kit ID found")
    if not kills["kit_id_victim"].isin(valid_kill_kit_ids).all():
        raise ValueError("Unknown victim kit ID found")
    if not damage_received["kit_id_source"].isin(valid_kill_kit_ids).all():
        raise ValueError("Unknown damage-source kit ID found")
    if not damage_received["kit_id_target"].isin(valid_kill_kit_ids).all():
        raise ValueError("Unknown damage-target kit ID found")
    if not abilities["kit_id"].isin(KIT_ID_TO_NAME).all():
        raise ValueError("Unknown ability kit ID found")
    valid_pick_ids = set(KIT_ID_TO_NAME) | {NO_KIT_ID}
    if not picks["kit_id"].isin(valid_pick_ids).all():
        raise ValueError("Unknown pick kit ID found")
    if not ability_metadata["kit_id"].isin(KIT_ID_TO_NAME).all():
        raise ValueError("Unknown ability-metadata kit ID found")
    if kills.duplicated(
        [
            "id_killer",
            "kit_id_killer",
            "id_victim",
            "kit_id_victim",
            "cause_id",
        ]
    ).any():
        raise ValueError("Duplicate kill-stat rows found")
    if damage_received.duplicated(
        [
            "id_target",
            "kit_id_target",
            "id_source",
            "kit_id_source",
            "cause_id",
        ]
    ).any():
        raise ValueError("Duplicate damage-stat rows found")
    if abilities.duplicated(
        ["id", "kit_id", "ability_path", "metric_id"]
    ).any():
        raise ValueError("Duplicate ability-metric rows found")
    if picks.duplicated(["id", "kit_id"]).any():
        raise ValueError("Duplicate pick-stat rows found")
    if ability_metadata.duplicated(
        ["kit_id", "ability_path", "metric_id"]
    ).any():
        raise ValueError("Duplicate ability-metadata rows found")
    if damage_causes.duplicated(["cause_id"]).any():
        raise ValueError("Duplicate damage-cause metadata rows found")

    missing_metadata = set(KIT_ID_TO_NAME) - set(ability_metadata["kit_id"])
    if missing_metadata:
        raise ValueError(
            "Missing ability metadata for kit IDs: "
            f"{sorted(missing_metadata)}"
        )

    abilities_per_kit = ability_metadata.groupby("kit_id")[
        "ability_path"
    ].nunique()
    if (abilities_per_kit != 1).any():
        invalid = abilities_per_kit.loc[abilities_per_kit != 1].index.tolist()
        raise ValueError(
            "Expected exactly one ability per kit; invalid kit IDs: "
            f"{invalid}"
        )

    uses_rows = ability_metadata.loc[ability_metadata["metric_id"] == "uses"]
    if set(uses_rows["kit_id"]) != set(KIT_ID_TO_NAME):
        raise ValueError("Every kit must define one canonical 'uses' metric")
    if uses_rows["display_unit"].ne("uses").any():
        raise ValueError("Canonical 'uses' metrics must use display unit 'uses'")

    reserved_metric_ids = {"uses", "successful_uses"}
    effect_counts = (
        ability_metadata.loc[
            ~ability_metadata["metric_id"].isin(reserved_metric_ids)
        ]
        .groupby("kit_id")["metric_id"]
        .nunique()
    )
    if (effect_counts > 1).any():
        invalid = effect_counts.loc[effect_counts > 1].index.tolist()
        raise ValueError(
            "Expected at most one effectiveness metric per kit; invalid "
            f"kit IDs: {invalid}"
        )

    metadata_keys = set(
        ability_metadata[["kit_id", "ability_path", "metric_id"]]
        .itertuples(index=False, name=None)
    )
    observed_keys = set(
        abilities[["kit_id", "ability_path", "metric_id"]]
        .itertuples(index=False, name=None)
    )
    unknown_metrics = observed_keys - metadata_keys
    if unknown_metrics:
        raise ValueError(
            "Ability rows reference missing metadata: "
            f"{sorted(unknown_metrics)}"
        )

    count_metric_values = abilities.loc[
        abilities["metric_id"].isin(reserved_metric_ids), "value"
    ]
    if not np.allclose(count_metric_values, np.round(count_metric_values)):
        raise ValueError("Ability use metrics must contain whole counts")

    observed_cause_ids = set(kills["cause_id"]) | set(
        damage_received["cause_id"]
    )
    missing_cause_names = observed_cause_ids - set(damage_causes["cause_id"])
    if missing_cause_names:
        raise ValueError(
            "Missing names for damage-cause IDs: "
            f"{sorted(missing_cause_names)}"
        )

    return (
        kills,
        damage_received,
        abilities,
        picks,
        ability_metadata,
        damage_causes,
    )


def _require_columns(
    frame: pd.DataFrame,
    required: Sequence[str],
    name: str,
) -> None:
    missing = set(required) - set(frame.columns)
    if missing:
        raise ValueError(f"{name} is missing columns: {sorted(missing)}")


def _validate_and_normalize_elo(
    elo_metadata: pd.DataFrame,
    elo_ratings: pd.DataFrame,
) -> tuple[pd.DataFrame, pd.DataFrame]:
    """Validate the optional Elo snapshot emitted by schema version 5."""

    _require_columns(elo_metadata, ELO_METADATA_COLUMNS, "elo_metadata")
    _require_columns(elo_ratings, ELO_RATING_COLUMNS, "elo_ratings")
    metadata = elo_metadata.copy()
    ratings = elo_ratings.copy()

    if metadata.empty:
        if not ratings.empty:
            raise ValueError("elo_ratings requires non-empty elo_metadata")
        return metadata, ratings

    if metadata[list(ELO_METADATA_COLUMNS)].isna().any().any():
        raise ValueError("elo_metadata contains missing values")
    if ratings[list(ELO_RATING_COLUMNS)].isna().any().any():
        raise ValueError("elo_ratings contains missing values")

    string_columns = (
        "elo_name",
        "elo_description",
        "algorithm",
        "result_type",
        "update_mode",
        "metric_id",
        "metric_name",
        "metric_description",
        "stored_unit",
        "display_unit",
    )
    for column in string_columns:
        metadata[column] = metadata[column].astype(str)
        if metadata[column].str.strip().eq("").any():
            raise ValueError(f"Blank Elo metadata value found in {column}")

    numeric_columns = (
        "initial_rating",
        "k_factor",
        "rating_divisor",
        "display_scale",
    )
    for column in numeric_columns:
        metadata[column] = pd.to_numeric(
            metadata[column], errors="raise"
        ).astype(float)
        if not np.isfinite(metadata[column]).all():
            raise ValueError(f"Non-finite Elo metadata value found in {column}")

    boolean_columns = (
        "major_events_rated",
        "environmental_deaths_rated",
        "self_kills_rated",
    )
    for column in boolean_columns:
        metadata[column] = metadata[column].astype("boolean").astype(bool)

    if (metadata["k_factor"] <= 0).any():
        raise ValueError("Elo k_factor must be positive")
    if (metadata["rating_divisor"] <= 0).any():
        raise ValueError("Elo rating_divisor must be positive")
    if (metadata["display_scale"] <= 0).any():
        raise ValueError("Elo display scales must be positive")
    if metadata.duplicated("metric_id").any():
        raise ValueError("Duplicate Elo metric metadata rows found")

    required_metric_ids = {"rating", "rated_encounters"}
    missing_metrics = required_metric_ids - set(metadata["metric_id"])
    if missing_metrics:
        raise ValueError(
            f"Missing Elo metric metadata: {sorted(missing_metrics)}"
        )

    configuration_columns = (
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
    )
    inconsistent = [
        column
        for column in configuration_columns
        if metadata[column].nunique(dropna=False) != 1
    ]
    if inconsistent:
        raise ValueError(
            "Inconsistent Elo configuration columns: "
            f"{sorted(inconsistent)}"
        )

    ratings["id"] = ratings["id"].astype(str)
    ratings["rating"] = pd.to_numeric(
        ratings["rating"], errors="raise"
    ).astype(float)
    encounters = pd.to_numeric(
        ratings["rated_encounters"], errors="raise"
    )
    if not np.allclose(encounters, np.round(encounters)):
        raise ValueError("rated_encounters must contain whole counts")
    ratings["rated_encounters"] = encounters.astype(int)
    if not np.isfinite(ratings["rating"]).all():
        raise ValueError("Non-finite Elo rating found")
    if (ratings["rated_encounters"] < 0).any():
        raise ValueError("Negative rated_encounters found")
    if ratings["id"].eq(NO_PLAYER_ID).any():
        raise ValueError("The no-player sentinel cannot have an Elo rating")
    if ratings.duplicated("id").any():
        raise ValueError("Duplicate Elo rating rows found")

    return (
        metadata.sort_values("metric_id").reset_index(drop=True),
        ratings.sort_values("id").reset_index(drop=True),
    )

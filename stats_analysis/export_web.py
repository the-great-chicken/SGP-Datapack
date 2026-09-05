from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Any, Callable

import nbtlib
import pandas as pd

from extract import (
    extract_abilities,
    extract_ability_metadata,
    extract_damage_causes,
    extract_damage_received,
    extract_death_position_metadata,
    extract_death_positions,
    extract_elo_metadata,
    extract_elo_ratings,
    extract_kills,
    extract_picks,
    extract_players,
    get_ability_metadata,
    get_damage_cause_names,
    get_death_position_metadata,
    get_death_positions,
    get_elo_metadata,
    get_elo_ratings,
    get_kits_dict,
    get_players,
    get_schema_version,
    iter_damage_received,
)


SNAPSHOT_SCHEMA_VERSION = 1
NO_PLAYER_ID = "-1"


class StatisticsExportError(RuntimeError):
    """The collected statistics cannot be represented by the snapshot contract."""


def extract_statistics(input_path: Path) -> tuple[int, dict[str, pd.DataFrame]]:
    """Extract publication statistics directly from command storage without Parquet."""
    nbt_file = nbtlib.load(input_path)
    schema_version = get_schema_version(nbt_file)
    kits_dict = get_kits_dict(nbt_file)
    players_data = get_players(nbt_file)
    ability_metadata = get_ability_metadata(nbt_file)
    damage_cause_names = get_damage_cause_names(nbt_file)
    death_position_metadata = get_death_position_metadata(nbt_file)
    death_positions_data = get_death_positions(nbt_file)
    elo_metadata = get_elo_metadata(nbt_file)
    elo_ratings = get_elo_ratings(nbt_file)
    damage_rows = list(iter_damage_received(kits_dict))

    return schema_version, {
        "players": extract_players(players_data),
        "kills": extract_kills(kits_dict),
        "damage_received": extract_damage_received(damage_rows),
        "abilities": extract_abilities(kits_dict, ability_metadata, damage_rows),
        "picks": extract_picks(kits_dict),
        "ability_metadata": extract_ability_metadata(ability_metadata),
        "damage_causes": extract_damage_causes(damage_cause_names),
        "death_position_metadata": extract_death_position_metadata(death_position_metadata),
        "death_positions": extract_death_positions(death_positions_data, death_position_metadata),
        "elo_metadata": extract_elo_metadata(elo_metadata),
        "elo_ratings": extract_elo_ratings(elo_ratings, elo_metadata),
    }


def build_snapshot(
    *,
    datapack_release: str,
    statistics_schema_version: int,
    statistics: dict[str, pd.DataFrame],
) -> dict[str, Any]:
    """Build a deterministic, UUID-based SGP statistics snapshot."""
    datapack_release = datapack_release.strip()
    if not datapack_release:
        raise StatisticsExportError("datapack release must not be empty")

    players = statistics["players"]
    identities = _build_identity_map(players)

    ability_definitions = []
    for row in statistics["ability_metadata"].itertuples(index=False):
        source = {"type": str(row.source_type)}
        _add_optional(source, "field", row.source_field, str)
        _add_optional(source, "kitId", row.source_kit_id, int)
        cause_ids = _optional_list(row.source_cause_ids, int)
        if cause_ids is not None:
            source["causeIds"] = cause_ids
        _add_optional(source, "excludeSelf", row.source_exclude_self, bool)

        ability_definitions.append(
            {
                "kitId": int(row.kit_id),
                "abilityPath": str(row.ability_path),
                "metricId": str(row.metric_id),
                "name": str(row.metric_name),
                "description": str(row.description),
                "cooldownTicks": _optional(row.cooldown_ticks, int),
                "durationTicks": _optional(row.duration_ticks, int),
                "settings": json.loads(row.settings_json) if _present(row.settings_json) else None,
                "storedUnit": str(row.stored_unit),
                "displayUnit": str(row.display_unit),
                "displayScale": float(row.display_scale),
                "source": source,
            }
        )

    snapshot = {
        "$schema": "statistics-snapshot.schema.json",
        "schemaVersion": SNAPSHOT_SCHEMA_VERSION,
        "datapackRelease": datapack_release,
        "statisticsSchemaVersion": statistics_schema_version,
        "players": [
            {
                "sgpId": int(row.id),
                "uuid": str(row.uuid),
                "minecraftName": str(row.nickname),
            }
            for row in players.itertuples(index=False)
        ],
        "damageCauses": [
            {"id": int(row.cause_id), "name": str(row.cause_name)}
            for row in statistics["damage_causes"].itertuples(index=False)
        ],
        "kills": [
            {
                "killerUuid": _resolve_player(row.id_killer, identities, "kills.killer"),
                "killerKitId": int(row.kit_id_killer),
                "victimUuid": _resolve_player(row.id_victim, identities, "kills.victim"),
                "victimKitId": int(row.kit_id_victim),
                "causeId": int(row.cause_id),
                "count": int(row.kills),
            }
            for row in statistics["kills"].itertuples(index=False)
        ],
        "damageReceived": [
            {
                "targetUuid": _resolve_required_player(row.id_target, identities, "damage.target"),
                "targetKitId": int(row.kit_id_target),
                "sourceUuid": _resolve_player(row.id_source, identities, "damage.source"),
                "sourceKitId": int(row.kit_id_source),
                "causeId": int(row.cause_id),
                "amount": float(row.damage_received),
            }
            for row in statistics["damage_received"].itertuples(index=False)
        ],
        "picks": [
            {
                "playerUuid": _resolve_required_player(row.id, identities, "picks.player"),
                "kitId": int(row.kit_id),
                "totalTimeTicks": int(row.total_time),
                "count": int(row.nbr_picks),
            }
            for row in statistics["picks"].itertuples(index=False)
        ],
        "abilityMetricDefinitions": ability_definitions,
        "abilityMetrics": [
            {
                "playerUuid": _resolve_required_player(row.id, identities, "abilities.player"),
                "kitId": int(row.kit_id),
                "abilityPath": str(row.ability_path),
                "metricId": str(row.metric_id),
                "value": float(row.value),
            }
            for row in statistics["abilities"].itertuples(index=False)
        ],
        "deathPositions": _build_death_positions(statistics),
        "elo": _build_elo(statistics, identities),
    }

    for key in [
        "players",
        "damageCauses",
        "kills",
        "damageReceived",
        "picks",
        "abilityMetricDefinitions",
        "abilityMetrics",
    ]:
        snapshot[key] = sorted(snapshot[key], key=_json_sort_key)

    return snapshot


def render_snapshot(snapshot: dict[str, Any]) -> str:
    return json.dumps(snapshot, ensure_ascii=False, indent=2, allow_nan=False) + "\n"


def _build_identity_map(players: pd.DataFrame) -> dict[str, str]:
    identities: dict[str, str] = {}
    seen_uuids: set[str] = set()
    for row in players.itertuples(index=False):
        player_id = str(row.id)
        player_uuid = str(row.uuid)
        if player_id == NO_PLAYER_ID or player_id in identities:
            raise StatisticsExportError(f"invalid or duplicate player id {player_id!r}")
        if player_uuid in seen_uuids:
            raise StatisticsExportError(f"duplicate player UUID {player_uuid}")
        identities[player_id] = player_uuid
        seen_uuids.add(player_uuid)
    return identities


def _resolve_player(player_id: Any, identities: dict[str, str], path: str) -> str | None:
    player_id = str(player_id)
    if player_id == NO_PLAYER_ID:
        return None
    if player_id not in identities:
        raise StatisticsExportError(f"{path} references unknown sgp.id {player_id}")
    return identities[player_id]


def _resolve_required_player(player_id: Any, identities: dict[str, str], path: str) -> str:
    player_uuid = _resolve_player(player_id, identities, path)
    if player_uuid is None:
        raise StatisticsExportError(f"{path} cannot reference the no-player sentinel")
    return player_uuid


def _build_death_positions(statistics: dict[str, pd.DataFrame]) -> dict[str, Any]:
    metadata_rows = statistics["death_position_metadata"]
    if len(metadata_rows) != 1:
        raise StatisticsExportError("expected exactly one death-position metadata row")
    metadata = metadata_rows.iloc[0]
    entries = [
        {
            "dimension": str(row.dimension),
            "x": float(row.x),
            "y": float(row.y),
            "z": float(row.z),
            "deaths": int(row.deaths),
        }
        for row in statistics["death_positions"].itertuples(index=False)
    ]
    return {
        "metadata": {
            "storedUnit": str(metadata.stored_unit),
            "displayUnit": str(metadata.display_unit),
            "displayScale": float(metadata.display_scale),
            "quantization": str(metadata.quantization),
            "positionReference": str(metadata.position_reference),
        },
        "entries": sorted(entries, key=_json_sort_key),
    }


def _build_elo(statistics: dict[str, pd.DataFrame], identities: dict[str, str]) -> dict[str, Any]:
    metadata_rows = statistics["elo_metadata"]
    if metadata_rows.empty:
        raise StatisticsExportError("expected Elo metadata")

    first = metadata_rows.iloc[0]
    configuration_fields = ["initial_rating", "k_factor", "rating_divisor"]
    for field in configuration_fields:
        if not (metadata_rows[field] == first[field]).all():
            raise StatisticsExportError(f"Elo metadata has inconsistent {field}")

    metrics = [
        {
            "id": str(row.metric_id),
            "name": str(row.metric_name),
            "description": str(row.metric_description),
            "storedUnit": str(row.stored_unit),
            "displayUnit": str(row.display_unit),
            "displayScale": float(row.display_scale),
        }
        for row in metadata_rows.itertuples(index=False)
    ]
    ratings = [
        {
            "playerUuid": _resolve_required_player(row.id, identities, "elo.player"),
            "rating": float(row.rating),
            "ratedEncounters": int(row.rated_encounters),
        }
        for row in statistics["elo_ratings"].itertuples(index=False)
    ]
    return {
        "metadata": {
            "initialRating": float(first.initial_rating),
            "kFactor": float(first.k_factor),
            "ratingDivisor": float(first.rating_divisor),
            "metrics": sorted(metrics, key=_json_sort_key),
        },
        "ratings": sorted(ratings, key=_json_sort_key),
    }


def _present(value: Any) -> bool:
    if value is None or value is pd.NA:
        return False
    return not (isinstance(value, float) and pd.isna(value))


def _optional(value: Any, convert: Callable[[Any], Any]) -> Any:
    return convert(value) if _present(value) else None


def _optional_list(value: Any, convert: Callable[[Any], Any]) -> list[Any] | None:
    if not _present(value):
        return None
    return [convert(item) for item in value]


def _add_optional(
    target: dict[str, Any],
    key: str,
    value: Any,
    convert: Callable[[Any], Any],
) -> None:
    converted = _optional(value, convert)
    if converted is not None:
        target[key] = converted


def _json_sort_key(value: dict[str, Any]) -> str:
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":"))


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Export a versioned SGP statistics snapshot."
    )
    parser.add_argument("input", nargs="?", type=Path, default=Path("command_storage.dat"))
    parser.add_argument(
        "--datapack-release",
        required=True,
        help="Immutable release identifier for the datapack that collected the statistics.",
    )
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        default=Path("statistics-snapshot.json"),
    )
    return parser


def main() -> int:
    args = build_parser().parse_args()

    try:
        schema_version, statistics = extract_statistics(args.input)
        snapshot = build_snapshot(
            datapack_release=args.datapack_release,
            statistics_schema_version=schema_version,
            statistics=statistics,
        )
    except (OSError, ValueError, RuntimeError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1

    output = args.output.resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    temporary = output.with_name(f".{output.name}.tmp")
    temporary.write_text(render_snapshot(snapshot), encoding="utf-8")
    temporary.replace(output)
    print(
        f"Exported statistics from datapack release {snapshot['datapackRelease']} "
        f"with {len(snapshot['players'])} players, {len(snapshot['kills'])} kill rows "
        f"and {len(snapshot['damageReceived'])} damage rows to {output}."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

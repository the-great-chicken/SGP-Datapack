from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime, timezone
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


BUNDLE_SCHEMA_VERSION = 1
KIT_MANIFEST_SCHEMA_VERSION = 2
NO_PLAYER_ID = "-1"


class WebExportError(RuntimeError):
    """The completed edition cannot be represented by the web contract."""


def extract_statistics(input_path: Path) -> tuple[int, dict[str, pd.DataFrame]]:
    """Extract website inputs directly from command storage without Parquet."""
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


def build_bundle(
    *,
    edition_number: int,
    edition_name: str | None,
    status: str,
    starts_at: str | None,
    ends_at: str | None,
    published_at: str | None,
    datapack_version: str | None,
    resource_pack_version: str | None,
    statistics_schema_version: int,
    kit_manifest: dict[str, Any],
    statistics: dict[str, pd.DataFrame],
) -> dict[str, Any]:
    """Build a deterministic, UUID-based edition bundle."""
    if edition_number < 1:
        raise WebExportError("edition number must be positive")
    if status not in {"draft", "published", "archived"}:
        raise WebExportError(f"unsupported edition status {status!r}")
    if status == "published" and published_at is None:
        raise WebExportError("published editions require --published-at")

    _validate_kit_manifest(kit_manifest)
    players = statistics["players"]
    identities = _build_identity_map(players)
    kit_abilities = {
        (kit["id"], kit["ability"]["path"])
        for kit in kit_manifest["kits"]
        if kit.get("id") is not None and kit.get("ability") is not None
    }

    ability_definitions = []
    for row in statistics["ability_metadata"].itertuples(index=False):
        ability_key = (int(row.kit_id), str(row.ability_path))
        if ability_key not in kit_abilities:
            raise WebExportError(
                "ability metadata does not match the kit manifest: "
                f"kit {ability_key[0]}, ability {ability_key[1]!r}"
            )
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

    bundle = {
        "schemaVersion": BUNDLE_SCHEMA_VERSION,
        "edition": {
            "number": edition_number,
            "name": edition_name,
            "status": status,
            "startsAt": _normalize_datetime(starts_at, "starts-at"),
            "endsAt": _normalize_datetime(ends_at, "ends-at"),
            "publishedAt": _normalize_datetime(published_at, "published-at"),
            "minecraftVersion": kit_manifest["minecraftVersion"],
            "datapackVersion": datapack_version,
            "resourcePackVersion": resource_pack_version,
            "statisticsSchemaVersion": statistics_schema_version,
        },
        "kitManifest": kit_manifest,
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
        bundle[key] = sorted(bundle[key], key=_json_sort_key)

    return bundle


def render_bundle(bundle: dict[str, Any]) -> str:
    return json.dumps(bundle, ensure_ascii=False, indent=2, allow_nan=False) + "\n"


def _build_identity_map(players: pd.DataFrame) -> dict[str, str]:
    identities: dict[str, str] = {}
    seen_uuids: set[str] = set()
    for row in players.itertuples(index=False):
        player_id = str(row.id)
        player_uuid = str(row.uuid)
        if player_id == NO_PLAYER_ID or player_id in identities:
            raise WebExportError(f"invalid or duplicate player id {player_id!r}")
        if player_uuid in seen_uuids:
            raise WebExportError(f"duplicate player UUID {player_uuid}")
        identities[player_id] = player_uuid
        seen_uuids.add(player_uuid)
    return identities


def _resolve_player(player_id: Any, identities: dict[str, str], path: str) -> str | None:
    player_id = str(player_id)
    if player_id == NO_PLAYER_ID:
        return None
    if player_id not in identities:
        raise WebExportError(f"{path} references unknown sgp.id {player_id}")
    return identities[player_id]


def _resolve_required_player(player_id: Any, identities: dict[str, str], path: str) -> str:
    player_uuid = _resolve_player(player_id, identities, path)
    if player_uuid is None:
        raise WebExportError(f"{path} cannot reference the no-player sentinel")
    return player_uuid


def _build_death_positions(statistics: dict[str, pd.DataFrame]) -> dict[str, Any]:
    metadata_rows = statistics["death_position_metadata"]
    if len(metadata_rows) != 1:
        raise WebExportError("expected exactly one death-position metadata row")
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
        raise WebExportError("expected Elo metadata")

    first = metadata_rows.iloc[0]
    configuration_fields = ["initial_rating", "k_factor", "rating_divisor"]
    for field in configuration_fields:
        if not (metadata_rows[field] == first[field]).all():
            raise WebExportError(f"Elo metadata has inconsistent {field}")

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


def _validate_kit_manifest(manifest: dict[str, Any]) -> None:
    if manifest.get("schemaVersion") != KIT_MANIFEST_SCHEMA_VERSION:
        raise WebExportError(
            f"kit manifest schema must be {KIT_MANIFEST_SCHEMA_VERSION}"
        )
    if not isinstance(manifest.get("minecraftVersion"), str):
        raise WebExportError("kit manifest has no Minecraft version")
    if not isinstance(manifest.get("kits"), list):
        raise WebExportError("kit manifest has no kits array")


def _normalize_datetime(value: str | None, label: str) -> str | None:
    if value is None:
        return None
    try:
        parsed = datetime.fromisoformat(value.replace("Z", "+00:00"))
    except ValueError as exc:
        raise WebExportError(f"{label} must be an ISO 8601 datetime") from exc
    if parsed.tzinfo is None:
        raise WebExportError(f"{label} must include a timezone")
    return parsed.astimezone(timezone.utc).isoformat(timespec="seconds").replace("+00:00", "Z")


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


def _read_json(path: Path) -> dict[str, Any]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise WebExportError(f"could not read JSON from {path}: {exc}") from exc
    if not isinstance(value, dict):
        raise WebExportError(f"expected a JSON object in {path}")
    return value


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Export a completed SGP edition for the website."
    )
    parser.add_argument("input", nargs="?", type=Path, default=Path("command_storage.dat"))
    parser.add_argument("--kit-manifest", type=Path, required=True)
    parser.add_argument("--edition", type=int, required=True)
    parser.add_argument("--name")
    parser.add_argument("--status", choices=["draft", "published", "archived"], default="draft")
    parser.add_argument("--starts-at")
    parser.add_argument("--ends-at")
    parser.add_argument("--published-at")
    parser.add_argument("--datapack-version")
    parser.add_argument("--resource-pack-version")
    parser.add_argument("-o", "--output", type=Path)
    return parser


def main() -> int:
    args = build_parser().parse_args()
    output = args.output or Path(f"edition-{args.edition:03d}.json")

    try:
        schema_version, statistics = extract_statistics(args.input)
        bundle = build_bundle(
            edition_number=args.edition,
            edition_name=args.name,
            status=args.status,
            starts_at=args.starts_at,
            ends_at=args.ends_at,
            published_at=args.published_at,
            datapack_version=args.datapack_version,
            resource_pack_version=args.resource_pack_version,
            statistics_schema_version=schema_version,
            kit_manifest=_read_json(args.kit_manifest),
            statistics=statistics,
        )
    except (OSError, ValueError, RuntimeError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1

    output = output.resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    temporary = output.with_name(f".{output.name}.tmp")
    temporary.write_text(render_bundle(bundle), encoding="utf-8")
    temporary.replace(output)
    print(
        f"Exported edition {args.edition} with {len(bundle['players'])} players, "
        f"{len(bundle['kills'])} kill rows and {len(bundle['damageReceived'])} "
        f"damage rows to {output}."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

from __future__ import annotations

import argparse
from pathlib import Path
from typing import Any

import nbtlib
import pandas as pd


STATS_PATH = ("data", "contents", "stats")
KITS_PATH = (*STATS_PATH, "kits_dict")
KIT_SETTINGS_PATH = (*STATS_PATH, "kit_settings")
DAMAGE_CAUSE_NAMES_PATH = (*STATS_PATH, "damage_cause_names")
DAMAGE_TENTHS_PER_HEALTH_POINT = 10


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


def get_kit_settings(nbt_file: nbtlib.File) -> Any:
    """Return the kit settings snapshot from command_storage.dat."""
    return get_nbt_path(nbt_file, KIT_SETTINGS_PATH)


def get_damage_cause_names(nbt_file: nbtlib.File) -> Any:
    """Return the shared damage-cause names from command_storage.dat."""
    return get_nbt_path(nbt_file, DAMAGE_CAUSE_NAMES_PATH)


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


def extract_damage_received(kits_dict: Any) -> pd.DataFrame:
    """
    Extract cumulative damage received statistics.

    Columns:
        id_target
        kit_id_target
        id_source
        kit_id_source
        cause_id
        damage_received

    The stored values are integer tenths of a health point. They are converted
    to health points here, where 2 health points equal one full heart.
    """
    rows: list[dict[str, Any]] = []

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
                        rows.append(
                            {
                                "id_target": str(id_target),
                                "kit_id_target": int(kit_id_target),
                                "id_source": str(id_source),
                                "kit_id_source": int(kit_id_source),
                                "cause_id": int(cause_id),
                                "damage_received": (
                                    int(damage_tenths)
                                    / DAMAGE_TENTHS_PER_HEALTH_POINT
                                ),
                            }
                        )

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


def extract_ability_usage(kits_dict: Any) -> pd.DataFrame:
    """
    Extract ability usage statistics.

    Columns:
        id
        kit_id
        ability_use
    """
    rows: list[dict[str, Any]] = []

    for player_id, player_data in kits_dict.items():
        for kit_id, kit_data in player_data.items():
            if "ability_use" not in kit_data:
                continue

            rows.append(
                {
                    "id": str(player_id),
                    "kit_id": int(kit_id),
                    "ability_use": int(kit_data["ability_use"]),
                }
            )

    return pd.DataFrame(
        rows,
        columns=[
            "id",
            "kit_id",
            "ability_use",
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


def extract_kit_settings(kit_settings: Any) -> pd.DataFrame:
    """
    Extract the kit settings snapshot.

    Columns:
        kit_id
        ability_cooldown

    Ability cooldowns are expressed in ticks.
    """
    rows: list[dict[str, Any]] = []

    for kit_id, settings in kit_settings.items():
        if "ability_cooldown" not in settings:
            continue

        rows.append(
            {
                "kit_id": int(kit_id),
                "ability_cooldown": int(settings["ability_cooldown"]),
            }
        )

    return (
        pd.DataFrame(
            rows,
            columns=[
                "kit_id",
                "ability_cooldown",
            ],
        )
        .sort_values("kit_id")
        .reset_index(drop=True)
    )


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


def extract(input_path: Path, output_dir: Path) -> None:
    """Extract statistics from command_storage.dat into Parquet files."""
    print(f"Reading {input_path}")

    nbt_file = nbtlib.load(input_path)
    kits_dict = get_kits_dict(nbt_file)
    kit_settings = get_kit_settings(nbt_file)
    damage_cause_names = get_damage_cause_names(nbt_file)

    kills = extract_kills(kits_dict)
    damage_received = extract_damage_received(kits_dict)
    abilities = extract_ability_usage(kits_dict)
    picks = extract_picks(kits_dict)
    settings = extract_kit_settings(kit_settings)
    damage_causes = extract_damage_causes(damage_cause_names)

    output_dir.mkdir(parents=True, exist_ok=True)

    kills_path = output_dir / "kills.parquet"
    damage_received_path = output_dir / "damage_received.parquet"
    abilities_path = output_dir / "abilities.parquet"
    picks_path = output_dir / "picks.parquet"
    settings_path = output_dir / "kit_settings.parquet"
    damage_causes_path = output_dir / "damage_causes.parquet"

    kills.to_parquet(kills_path, index=False)
    damage_received.to_parquet(damage_received_path, index=False)
    abilities.to_parquet(abilities_path, index=False)
    picks.to_parquet(picks_path, index=False)
    settings.to_parquet(settings_path, index=False)
    damage_causes.to_parquet(damage_causes_path, index=False)

    print(f"Kills:      {len(kills):,} rows -> {kills_path}")
    print(
        f"Damage:     {len(damage_received):,} rows -> {damage_received_path}"
    )
    print(f"Abilities:  {len(abilities):,} rows -> {abilities_path}")
    print(f"Picks:      {len(picks):,} rows -> {picks_path}")
    print(f"Settings:   {len(settings):,} rows -> {settings_path}")
    print(f"Causes:     {len(damage_causes):,} rows -> {damage_causes_path}")


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

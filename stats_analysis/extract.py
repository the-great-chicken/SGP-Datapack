from __future__ import annotations

import argparse
from pathlib import Path
from typing import Any

import nbtlib
import pandas as pd


KITS_PATH = ("data", "contents", "stats", "kits_dict")


def get_kits_dict(nbt_file: nbtlib.File) -> Any:
    """Return kits_dict from command_storage.dat."""
    try:
        value = nbt_file

        for key in KITS_PATH:
            value = value[key]

        return value

    except KeyError as exc:
        path = ".".join(KITS_PATH)
        raise RuntimeError(
            f"Could not find the expected NBT path: {path}\n"
            "Check that this is the correct command_storage.dat file."
        ) from exc


def extract_kills(kits_dict: Any) -> pd.DataFrame:
    """
    Extract kill statistics.

    Columns:
        id_killer
        kit_id_killer
        kit_id_victim
        kills
    """
    rows: list[dict[str, Any]] = []

    for id_killer, player_data in kits_dict.items():
        for kit_id_killer, kit_data in player_data.items():
            kills_data = kit_data.get("kills", {})

            for kit_id_victim, kill_count in kills_data.items():
                rows.append(
                    {
                        "id_killer": str(id_killer),
                        "kit_id_killer": int(kit_id_killer),
                        "kit_id_victim": int(kit_id_victim),
                        "kills": int(kill_count),
                    }
                )

    return pd.DataFrame(
        rows,
        columns=[
            "id_killer",
            "kit_id_killer",
            "kit_id_victim",
            "kills",
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


def extract(input_path: Path, output_dir: Path) -> None:
    """Extract statistics from command_storage.dat into Parquet files."""
    print(f"Reading {input_path}")

    nbt_file = nbtlib.load(input_path)
    kits_dict = get_kits_dict(nbt_file)

    kills = extract_kills(kits_dict)
    abilities = extract_ability_usage(kits_dict)
    picks = extract_picks(kits_dict)

    output_dir.mkdir(parents=True, exist_ok=True)

    kills_path = output_dir / "kills.parquet"
    abilities_path = output_dir / "abilities.parquet"
    picks_path = output_dir / "picks.parquet"

    kills.to_parquet(kills_path, index=False)
    abilities.to_parquet(abilities_path, index=False)
    picks.to_parquet(picks_path, index=False)

    print(f"Kills:     {len(kills):,} rows -> {kills_path}")
    print(f"Abilities: {len(abilities):,} rows -> {abilities_path}")
    print(f"Picks:     {len(picks):,} rows -> {picks_path}")


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

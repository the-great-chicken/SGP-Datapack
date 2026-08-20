"""Loading, validation, and derived datasets for the SGP kit report.

This module deliberately contains no visualization code.  It turns the
normalized extracts into analysis-ready kit and player-kit tables that can be
consumed by the notebook, charts, or future exports.
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Sequence

import numpy as np
import pandas as pd


KIT_NAMES = (
    "pigeon",
    "combattant",
    "archer",
    "vindicateur",
    "pyromane",
    "tank",
    "roi",
    "eclaireur",
    "alchimiste",
    "enderman",
    "cancer",
    "poseidon",
)
KIT_ID_TO_NAME = dict(enumerate(KIT_NAMES))
KIT_ORDER = KIT_NAMES
NO_KIT_ID = -1
NO_PLAYER_ID = "-1"

KILL_COLUMNS = (
    "id_killer",
    "kit_id_killer",
    "kit_id_victim",
    "cause_id",
    "kills",
)
DAMAGE_COLUMNS = (
    "id_target",
    "kit_id_target",
    "id_source",
    "kit_id_source",
    "cause_id",
    "damage_received",
)
ABILITY_COLUMNS = ("id", "kit_id", "ability_use")
PICK_COLUMNS = ("id", "kit_id", "total_time", "nbr_picks")
KIT_SETTING_COLUMNS = ("kit_id", "ability_cooldown")
DAMAGE_CAUSE_COLUMNS = ("cause_id", "cause_name")

# The default assumes ``total_time`` is logged in Minecraft game ticks.  Keep
# the conversion configurable at the public entry points in case the datapack
# increments this counter at another cadence.
MINECRAFT_TICKS_PER_SECOND = 20
MINECRAFT_TICKS_PER_HOUR = MINECRAFT_TICKS_PER_SECOND * 60 * 60
DEFAULT_TIME_UNITS_PER_HOUR = MINECRAFT_TICKS_PER_HOUR


@dataclass(frozen=True)
class ReportData:
    """Validated extracts and reusable tables consumed by the report.

    Raw extract naming is preserved in ``picks``.  Analysis-facing tables call
    ``nbr_picks`` "completed_lives" because the counter represents completed
    full lives rather than every kit-selection event.
    """

    kills: pd.DataFrame
    damage_received: pd.DataFrame
    abilities: pd.DataFrame
    picks: pd.DataFrame
    kit_settings: pd.DataFrame
    all_kits: pd.DataFrame
    player_kit_kills: pd.DataFrame
    total_kills_by_kit: pd.DataFrame
    kit_kill_stats: pd.DataFrame
    kill_causes: pd.DataFrame
    outgoing_kills_by_cause: pd.DataFrame
    incoming_deaths_by_cause: pd.DataFrame
    matchup_kills_by_cause: pd.DataFrame
    death_metrics: pd.DataFrame
    player_kit_damage_dealt: pd.DataFrame
    total_damage_dealt_by_kit: pd.DataFrame
    kit_damage_dealt_stats: pd.DataFrame
    player_kit_damage_received: pd.DataFrame
    kit_damage_received_stats: pd.DataFrame
    damage_causes: pd.DataFrame
    outgoing_damage_by_cause: pd.DataFrame
    incoming_damage_by_cause: pd.DataFrame
    matchup_damage_by_cause: pd.DataFrame
    damage_metrics: pd.DataFrame
    matchup_matrix: pd.DataFrame
    directional_share: np.ndarray
    pair_totals: np.ndarray
    damage_matchup_matrix: pd.DataFrame
    damage_directional_share: np.ndarray
    damage_pair_totals: np.ndarray
    player_kit_abilities: pd.DataFrame
    total_abilities_by_kit: pd.DataFrame
    kit_ability_stats: pd.DataFrame
    player_kit_exposure: pd.DataFrame
    kit_exposure: pd.DataFrame
    player_kit_metrics: pd.DataFrame
    kit_metrics: pd.DataFrame
    top_killer_exposure: pd.DataFrame
    reach: pd.DataFrame
    combined_totals: pd.DataFrame
    summary: pd.DataFrame
    no_kit_exposure: pd.DataFrame
    n_players: int
    time_units_per_hour: float


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
    kit_settings = pd.read_parquet(data_dir / "kit_settings.parquet")
    damage_causes_path = data_dir / "damage_causes.parquet"
    if not damage_causes_path.exists():
        damage_causes_path = data_dir / "kill_causes.parquet"
    damage_causes = pd.read_parquet(damage_causes_path)
    return prepare_report_data(
        kills,
        abilities,
        picks,
        kit_settings,
        damage_causes,
        damage_received=damage_received,
        time_units_per_hour=time_units_per_hour,
    )


def prepare_report_data(
    kills: pd.DataFrame,
    abilities: pd.DataFrame,
    picks: pd.DataFrame,
    kit_settings: pd.DataFrame,
    kill_causes: pd.DataFrame,
    *,
    damage_received: pd.DataFrame | None = None,
    time_units_per_hour: float = DEFAULT_TIME_UNITS_PER_HOUR,
) -> ReportData:
    """Validate normalized inputs and derive analysis-ready datasets.

    ``kill_causes`` keeps the established public parameter name.  The new
    extract writes the same shared cause metadata to ``damage_causes.parquet``
    because it now describes both kill and damage rows.
    """

    if not np.isfinite(time_units_per_hour) or time_units_per_hour <= 0:
        raise ValueError("time_units_per_hour must be a positive finite value")

    if damage_received is None:
        damage_received = pd.DataFrame(columns=DAMAGE_COLUMNS)
    damage_causes = kill_causes

    (
        kills,
        damage_received,
        abilities,
        picks,
        kit_settings,
        damage_causes,
    ) = (
        _validate_and_normalize(
            kills,
            damage_received,
            abilities,
            picks,
            kit_settings,
            damage_causes,
        )
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
    kit_settings = all_kits.merge(
        kit_settings[list(KIT_SETTING_COLUMNS)],
        on="kit_id",
        how="left",
        validate="one_to_one",
    )
    kit_settings["ability_cooldown_seconds"] = (
        kit_settings["ability_cooldown"] / MINECRAFT_TICKS_PER_SECOND
    )
    kit_settings["theoretical_ability_uses_per_hour"] = (
        MINECRAFT_TICKS_PER_HOUR / kit_settings["ability_cooldown"]
    )

    player_kit_kills = (
        attributed_kills.groupby(
            ["id_killer", "kit_id_killer"], as_index=False
        )["kills"]
        .sum()
        .rename(columns={"kit_id_killer": "kit_id"})
    )
    player_kit_kills["kit_name"] = player_kit_kills["kit_id"].map(
        KIT_ID_TO_NAME
    )
    total_kills_by_kit = _complete_metric_totals(
        player_kit_kills,
        all_kits,
        "kills",
    )
    kill_concentration = _concentration_from_counts(
        player_kit_kills,
        group_col="kit_id",
        value_col="kills",
    )
    kit_kill_stats = (
        total_kills_by_kit.merge(kill_concentration, on="kit_id", how="left")
        .sort_values("kit_id")
        .reset_index(drop=True)
    )
    kit_kill_stats["players"] = pd.to_numeric(
        kit_kill_stats["players"], errors="coerce"
    ).fillna(0).astype(int)

    matchup_counts = attributed_kills.groupby(
        ["kit_id_killer", "kit_id_victim"], as_index=False
    )["kills"].sum()
    matchup_matrix = (
        matchup_counts.pivot(
            index="kit_id_killer",
            columns="kit_id_victim",
            values="kills",
        )
        .reindex(index=range(len(KIT_NAMES)), columns=range(len(KIT_NAMES)))
        .fillna(0)
        .astype(int)
    )
    directional_share, pair_totals = _directional_tables(matchup_matrix)

    # Offensive damage uses the same known-kit universe as attributed kills.
    # Incoming defensive metrics retain damage from unknown or non-player
    # sources as long as the target kit is known.
    attributed_damage = damage_received.loc[
        damage_received["kit_id_source"].isin(KIT_ID_TO_NAME)
        & damage_received["kit_id_target"].isin(KIT_ID_TO_NAME)
    ].copy()
    player_kit_damage_dealt = (
        attributed_damage.groupby(
            ["id_source", "kit_id_source"], as_index=False
        )["damage_received"]
        .sum()
        .rename(
            columns={
                "kit_id_source": "kit_id",
                "damage_received": "damage_dealt",
            }
        )
    )
    player_kit_damage_dealt["kit_name"] = player_kit_damage_dealt[
        "kit_id"
    ].map(KIT_ID_TO_NAME)
    total_damage_dealt_by_kit = _complete_metric_totals(
        player_kit_damage_dealt,
        all_kits,
        "damage_dealt",
        value_dtype=float,
    )
    damage_concentration = _concentration_from_counts(
        player_kit_damage_dealt,
        group_col="kit_id",
        value_col="damage_dealt",
    ).rename(
        columns={
            "players": "players_dealing_damage",
            "top_player_share": "top_player_damage_share",
            "top_3_share": "top_3_damage_share",
        }
    )
    kit_damage_dealt_stats = (
        total_damage_dealt_by_kit.merge(
            damage_concentration,
            on="kit_id",
            how="left",
        )
        .sort_values("kit_id")
        .reset_index(drop=True)
    )
    kit_damage_dealt_stats["players_dealing_damage"] = pd.to_numeric(
        kit_damage_dealt_stats["players_dealing_damage"], errors="coerce"
    ).fillna(0).astype(int)

    player_kit_damage_received = (
        damage_received.loc[
            damage_received["kit_id_target"].isin(KIT_ID_TO_NAME)
        ]
        .groupby(["id_target", "kit_id_target"], as_index=False)[
            "damage_received"
        ]
        .sum()
        .rename(columns={"kit_id_target": "kit_id"})
    )
    player_kit_damage_received["kit_name"] = player_kit_damage_received[
        "kit_id"
    ].map(KIT_ID_TO_NAME)
    total_damage_received_by_kit = _complete_metric_totals(
        player_kit_damage_received,
        all_kits,
        "damage_received",
        value_dtype=float,
    )
    received_damage_concentration = _concentration_from_counts(
        player_kit_damage_received,
        group_col="kit_id",
        value_col="damage_received",
    ).rename(
        columns={
            "players": "players_receiving_damage",
            "top_player_share": "top_player_received_damage_share",
            "top_3_share": "top_3_received_damage_share",
        }
    )
    kit_damage_received_stats = (
        total_damage_received_by_kit.merge(
            received_damage_concentration,
            on="kit_id",
            how="left",
        )
        .sort_values("kit_id")
        .reset_index(drop=True)
    )
    kit_damage_received_stats["players_receiving_damage"] = pd.to_numeric(
        kit_damage_received_stats["players_receiving_damage"],
        errors="coerce",
    ).fillna(0).astype(int)

    damage_matchup_counts = (
        attributed_damage.groupby(
            ["kit_id_source", "kit_id_target"], as_index=False
        )["damage_received"]
        .sum()
    )
    damage_matchup_matrix = (
        damage_matchup_counts.pivot(
            index="kit_id_source",
            columns="kit_id_target",
            values="damage_received",
        )
        .reindex(index=range(len(KIT_NAMES)), columns=range(len(KIT_NAMES)))
        .fillna(0.0)
        .astype(float)
    )
    damage_directional_share, damage_pair_totals = _directional_tables(
        damage_matchup_matrix,
        value_dtype=float,
    )

    player_kit_abilities = (
        abilities.loc[abilities["ability_use"] > 0]
        .groupby(["id", "kit_id"], as_index=False)["ability_use"]
        .sum()
    )
    player_kit_abilities["kit_name"] = player_kit_abilities["kit_id"].map(
        KIT_ID_TO_NAME
    )
    total_abilities_by_kit = _complete_metric_totals(
        player_kit_abilities,
        all_kits,
        "ability_use",
    )
    ability_concentration = _concentration_from_counts(
        player_kit_abilities.rename(columns={"ability_use": "value"}),
        group_col="kit_id",
        value_col="value",
    ).rename(
        columns={
            "players": "players_using_ability",
            "top_player_share": "top_player_ability_share",
            "top_3_share": "top_3_ability_share",
        }
    )
    kit_ability_stats = (
        total_abilities_by_kit.merge(
            ability_concentration,
            on="kit_id",
            how="left",
        )
        .sort_values("kit_id")
        .reset_index(drop=True)
    )
    kit_ability_stats["players_using_ability"] = pd.to_numeric(
        kit_ability_stats["players_using_ability"], errors="coerce"
    ).fillna(0).astype(int)

    damage_player_sources = damage_received.loc[
        damage_received["kit_id_source"].isin(KIT_ID_TO_NAME),
        "id_source",
    ]
    all_player_ids = (
        set(kills["id_killer"])
        | set(damage_received["id_target"])
        | set(damage_player_sources)
        | set(abilities["id"])
        | set(picks["id"])
    ) - {NO_PLAYER_ID}
    n_players = len(all_player_ids)

    player_kit_exposure, no_kit_exposure = _build_player_kit_exposure(
        picks,
        time_units_per_hour=time_units_per_hour,
    )
    kit_exposure = _build_kit_exposure(
        player_kit_exposure,
        all_kits,
        n_players=n_players,
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
        player_kit_exposure=player_kit_exposure,
        kit_exposure=kit_exposure,
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
    kit_settings: pd.DataFrame,
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
    _require_columns(kit_settings, KIT_SETTING_COLUMNS, "kit_settings")
    _require_columns(
        damage_causes,
        DAMAGE_CAUSE_COLUMNS,
        "damage_causes",
    )

    kills = kills.copy()
    damage_received = damage_received.copy()
    abilities = abilities.copy()
    picks = picks.copy()
    kit_settings = kit_settings.copy()
    damage_causes = damage_causes.copy()
    for frame, columns, name in (
        (kills, KILL_COLUMNS, "kills"),
        (damage_received, DAMAGE_COLUMNS, "damage_received"),
        (abilities, ABILITY_COLUMNS, "abilities"),
        (picks, PICK_COLUMNS, "picks"),
        (kit_settings, KIT_SETTING_COLUMNS, "kit_settings"),
        (damage_causes, DAMAGE_CAUSE_COLUMNS, "damage_causes"),
    ):
        if frame[list(columns)].isna().any().any():
            raise ValueError(f"{name} contains missing values")

    kills["id_killer"] = kills["id_killer"].astype(str)
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
    for column in ("kit_id", "ability_use"):
        abilities[column] = pd.to_numeric(
            abilities[column], errors="raise"
        ).astype(int)

    picks["id"] = picks["id"].astype(str)
    for column in ("kit_id", "total_time", "nbr_picks"):
        picks[column] = pd.to_numeric(picks[column], errors="raise").astype(int)

    for column in KIT_SETTING_COLUMNS:
        kit_settings[column] = pd.to_numeric(
            kit_settings[column], errors="raise"
        ).astype(int)

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
    if (abilities["ability_use"] < 0).any():
        raise ValueError("Negative ability-use count found")
    if (picks["total_time"] < 0).any():
        raise ValueError("Negative total_time found")
    if (picks["nbr_picks"] < 0).any():
        raise ValueError("Negative nbr_picks found")
    if (kit_settings["ability_cooldown"] <= 0).any():
        raise ValueError("Ability cooldowns must be positive")
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
    if not kit_settings["kit_id"].isin(KIT_ID_TO_NAME).all():
        raise ValueError("Unknown kit-settings kit ID found")
    if kills.duplicated(
        ["id_killer", "kit_id_killer", "kit_id_victim", "cause_id"]
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
    if abilities.duplicated(["id", "kit_id"]).any():
        raise ValueError("Duplicate ability-use rows found")
    if picks.duplicated(["id", "kit_id"]).any():
        raise ValueError("Duplicate pick-stat rows found")
    if kit_settings.duplicated(["kit_id"]).any():
        raise ValueError("Duplicate kit-settings rows found")
    if damage_causes.duplicated(["cause_id"]).any():
        raise ValueError("Duplicate damage-cause metadata rows found")

    missing_settings = set(KIT_ID_TO_NAME) - set(kit_settings["kit_id"])
    if missing_settings:
        raise ValueError(
            "Missing ability cooldowns for kit IDs: "
            f"{sorted(missing_settings)}"
        )

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
        kit_settings,
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


def _complete_metric_totals(
    per_player: pd.DataFrame,
    all_kits: pd.DataFrame,
    value_col: str,
    *,
    value_dtype: type = int,
) -> pd.DataFrame:
    observed = per_player.groupby(
        ["kit_id", "kit_name"], as_index=False
    )[value_col].sum()
    complete = all_kits.merge(
        observed,
        on=["kit_id", "kit_name"],
        how="left",
    ).fillna({value_col: 0})
    complete[value_col] = complete[value_col].astype(value_dtype)
    return complete


def _concentration_from_counts(
    frame: pd.DataFrame,
    *,
    group_col: str,
    value_col: str,
) -> pd.DataFrame:
    rows = []
    for group_value, group in frame.groupby(group_col):
        values = group.loc[group[value_col] > 0, value_col].sort_values(
            ascending=False
        )
        total = values.sum()
        rows.append(
            {
                group_col: group_value,
                "players": int(len(values)),
                "top_player_share": values.iloc[0] / total if total else np.nan,
                "top_3_share": values.iloc[:3].sum() / total if total else np.nan,
            }
        )
    return pd.DataFrame(
        rows,
        columns=[group_col, "players", "top_player_share", "top_3_share"],
    )


def _directional_tables(
    matchup_matrix: pd.DataFrame,
    *,
    value_dtype: type = int,
) -> tuple[np.ndarray, np.ndarray]:
    counts = matchup_matrix.to_numpy(dtype=value_dtype)
    pair_totals = counts + counts.T
    directional_share = np.full(counts.shape, np.nan, dtype=float)
    np.divide(
        counts,
        pair_totals,
        out=directional_share,
        where=pair_totals > 0,
    )
    np.fill_diagonal(directional_share, np.nan)
    np.fill_diagonal(pair_totals, 0)
    return directional_share, pair_totals


def _build_player_kit_exposure(
    picks: pd.DataFrame,
    *,
    time_units_per_hour: float,
) -> tuple[pd.DataFrame, pd.DataFrame]:
    exposure = (
        picks.loc[picks["kit_id"] != NO_KIT_ID]
        .rename(columns={"nbr_picks": "completed_lives"})
        .reset_index(drop=True)
        .copy()
    )
    exposure["kit_name"] = exposure["kit_id"].map(KIT_ID_TO_NAME)
    exposure["total_hours"] = exposure["total_time"] / time_units_per_hour

    player_time = exposure.groupby("id")["total_time"].transform("sum")
    player_lives = exposure.groupby("id")["completed_lives"].transform("sum")
    kit_time = exposure.groupby("kit_id")["total_time"].transform("sum")
    kit_lives = exposure.groupby("kit_id")["completed_lives"].transform("sum")
    exposure["time_share_within_player"] = _safe_divide(
        exposure["total_time"], player_time
    )
    exposure["completed_life_share_within_player"] = _safe_divide(
        exposure["completed_lives"], player_lives
    )
    exposure["player_time_share_of_kit"] = _safe_divide(
        exposure["total_time"], kit_time
    )
    exposure["player_completed_life_share_of_kit"] = _safe_divide(
        exposure["completed_lives"], kit_lives
    )
    exposure["time_per_completed_life"] = _safe_divide(
        exposure["total_time"], exposure["completed_lives"]
    )
    exposure["hours_per_completed_life"] = _safe_divide(
        exposure["total_hours"], exposure["completed_lives"]
    )

    no_kit = (
        picks.loc[picks["kit_id"] == NO_KIT_ID]
        .rename(columns={"nbr_picks": "completed_lives"})
        .reset_index(drop=True)
        .copy()
    )
    no_kit["total_hours"] = no_kit["total_time"] / time_units_per_hour
    return exposure, no_kit


def _build_kit_exposure(
    player_kit_exposure: pd.DataFrame,
    all_kits: pd.DataFrame,
    *,
    n_players: int,
) -> pd.DataFrame:
    totals = (
        player_kit_exposure.groupby("kit_id", as_index=False)[
            ["total_time", "total_hours", "completed_lives"]
        ]
        .sum()
    )
    exposure = all_kits.merge(totals, on="kit_id", how="left").fillna(
        {"total_time": 0, "total_hours": 0, "completed_lives": 0}
    )
    exposure[["total_time", "completed_lives"]] = exposure[
        ["total_time", "completed_lives"]
    ].astype(int)

    players_with_time = (
        player_kit_exposure.loc[player_kit_exposure["total_time"] > 0]
        .groupby("kit_id")["id"]
        .nunique()
        .reindex(range(len(KIT_NAMES)), fill_value=0)
    )
    players_with_lives = (
        player_kit_exposure.loc[
            player_kit_exposure["completed_lives"] > 0
        ]
        .groupby("kit_id")["id"]
        .nunique()
        .reindex(range(len(KIT_NAMES)), fill_value=0)
    )
    exposure["players_with_time"] = players_with_time.to_numpy(dtype=int)
    exposure["players_with_completed_life"] = players_with_lives.to_numpy(
        dtype=int
    )
    exposure["player_reach"] = (
        exposure["players_with_time"] / n_players if n_players else np.nan
    )
    exposure["completed_life_player_reach"] = (
        exposure["players_with_completed_life"] / n_players
        if n_players
        else np.nan
    )
    exposure["time_share"] = _safe_divide(
        exposure["total_time"],
        pd.Series(exposure["total_time"].sum(), index=exposure.index),
    )
    exposure["completed_life_share"] = _safe_divide(
        exposure["completed_lives"],
        pd.Series(exposure["completed_lives"].sum(), index=exposure.index),
    )
    exposure["time_per_completed_life"] = _safe_divide(
        exposure["total_time"], exposure["completed_lives"]
    )
    exposure["hours_per_completed_life"] = _safe_divide(
        exposure["total_hours"], exposure["completed_lives"]
    )

    time_concentration = _concentration_from_counts(
        player_kit_exposure,
        group_col="kit_id",
        value_col="total_time",
    ).rename(
        columns={
            "players": "players_contributing_time",
            "top_player_share": "top_player_time_share",
            "top_3_share": "top_3_time_share",
        }
    )
    life_concentration = _concentration_from_counts(
        player_kit_exposure,
        group_col="kit_id",
        value_col="completed_lives",
    ).rename(
        columns={
            "players": "players_contributing_completed_lives",
            "top_player_share": "top_player_completed_life_share",
            "top_3_share": "top_3_completed_life_share",
        }
    )
    exposure = exposure.merge(
        time_concentration, on="kit_id", how="left"
    ).merge(life_concentration, on="kit_id", how="left")
    integer_columns = (
        "players_contributing_time",
        "players_contributing_completed_lives",
    )
    for column in integer_columns:
        exposure[column] = pd.to_numeric(
            exposure[column], errors="coerce"
        ).fillna(0).astype(int)
    return exposure.sort_values("kit_id").reset_index(drop=True)


def _build_kill_cause_tables(
    kills: pd.DataFrame,
    attributed_kills: pd.DataFrame,
    all_kits: pd.DataFrame,
    kit_exposure: pd.DataFrame,
    kill_cause_names: pd.DataFrame,
) -> tuple[
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
]:
    """Build balance-oriented outgoing and incoming kill-cause tables."""

    deaths_with_kit = kills.loc[
        kills["kit_id_victim"].isin(KIT_ID_TO_NAME)
    ].copy()
    cause_ids = sorted(
        set(attributed_kills["cause_id"])
        | set(deaths_with_kit["cause_id"])
    )
    kill_causes = kill_cause_names.loc[
        kill_cause_names["cause_id"].isin(cause_ids),
        list(DAMAGE_CAUSE_COLUMNS),
    ].copy()
    cause_grid = all_kits.merge(kill_causes, how="cross")
    exposure_context = kit_exposure[
        ["kit_id", "total_hours", "completed_lives"]
    ]

    outgoing_counts = (
        attributed_kills.groupby(
            ["kit_id_killer", "cause_id"], as_index=False
        )["kills"]
        .sum()
        .rename(columns={"kit_id_killer": "kit_id"})
    )
    outgoing = (
        cause_grid.merge(
            outgoing_counts,
            on=["kit_id", "cause_id"],
            how="left",
        )
        .merge(exposure_context, on="kit_id", how="left")
        .fillna({"kills": 0})
    )
    outgoing["kills"] = outgoing["kills"].astype(int)
    outgoing["kit_total_kills"] = outgoing.groupby("kit_id")[
        "kills"
    ].transform("sum")
    outgoing["cause_share_of_kit_kills"] = _safe_divide(
        outgoing["kills"], outgoing["kit_total_kills"]
    )
    outgoing["cause_kills_per_hour"] = _safe_divide(
        outgoing["kills"], outgoing["total_hours"]
    )
    outgoing["cause_kills_per_completed_life"] = _safe_divide(
        outgoing["kills"], outgoing["completed_lives"]
    )

    incoming_counts = (
        deaths_with_kit.groupby(
            ["kit_id_victim", "cause_id"], as_index=False
        )["kills"]
        .sum()
        .rename(
            columns={
                "kit_id_victim": "kit_id",
                "kills": "deaths",
            }
        )
    )
    incoming = (
        cause_grid.merge(
            incoming_counts,
            on=["kit_id", "cause_id"],
            how="left",
        )
        .merge(exposure_context, on="kit_id", how="left")
        .fillna({"deaths": 0})
    )
    incoming["deaths"] = incoming["deaths"].astype(int)
    incoming["kit_total_deaths"] = incoming.groupby("kit_id")[
        "deaths"
    ].transform("sum")
    incoming["cause_share_of_kit_deaths"] = _safe_divide(
        incoming["deaths"], incoming["kit_total_deaths"]
    )
    incoming["cause_deaths_per_hour"] = _safe_divide(
        incoming["deaths"], incoming["total_hours"]
    )
    incoming["cause_deaths_per_completed_life"] = _safe_divide(
        incoming["deaths"], incoming["completed_lives"]
    )

    total_deaths = (
        deaths_with_kit.groupby("kit_id_victim", as_index=False)["kills"]
        .sum()
        .rename(
            columns={"kit_id_victim": "kit_id", "kills": "deaths"}
        )
    )
    player_deaths = (
        deaths_with_kit.loc[
            deaths_with_kit["kit_id_killer"].isin(KIT_ID_TO_NAME)
        ]
        .groupby("kit_id_victim", as_index=False)["kills"]
        .sum()
        .rename(
            columns={
                "kit_id_victim": "kit_id",
                "kills": "player_caused_deaths",
            }
        )
    )
    death_metrics = (
        all_kits.merge(total_deaths, on="kit_id", how="left")
        .merge(player_deaths, on="kit_id", how="left")
        .merge(exposure_context, on="kit_id", how="left")
        .fillna({"deaths": 0, "player_caused_deaths": 0})
    )
    death_metrics[["deaths", "player_caused_deaths"]] = death_metrics[
        ["deaths", "player_caused_deaths"]
    ].astype(int)
    death_metrics["non_player_deaths"] = (
        death_metrics["deaths"] - death_metrics["player_caused_deaths"]
    )
    death_metrics["deaths_per_hour"] = _safe_divide(
        death_metrics["deaths"], death_metrics["total_hours"]
    )
    death_metrics["deaths_per_completed_life"] = _safe_divide(
        death_metrics["deaths"], death_metrics["completed_lives"]
    )
    death_metrics["player_caused_death_share"] = _safe_divide(
        death_metrics["player_caused_deaths"], death_metrics["deaths"]
    )
    death_metrics["non_player_death_share"] = _safe_divide(
        death_metrics["non_player_deaths"], death_metrics["deaths"]
    )

    incoming = incoming.merge(
        death_metrics[
            [
                "kit_id",
                "deaths_per_hour",
                "player_caused_deaths",
                "non_player_deaths",
                "non_player_death_share",
            ]
        ].rename(columns={"deaths_per_hour": "kit_deaths_per_hour"}),
        on="kit_id",
        how="left",
    )

    matchup = (
        attributed_kills.groupby(
            ["kit_id_killer", "kit_id_victim", "cause_id"],
            as_index=False,
        )["kills"]
        .sum()
        .merge(kill_causes, on="cause_id", how="left")
    )
    matchup["killer_kit_name"] = matchup["kit_id_killer"].map(
        KIT_ID_TO_NAME
    )
    matchup["victim_kit_name"] = matchup["kit_id_victim"].map(
        KIT_ID_TO_NAME
    )

    return (
        kill_causes.sort_values("cause_id").reset_index(drop=True),
        outgoing.sort_values(["kit_id", "cause_id"]).reset_index(drop=True),
        incoming.sort_values(["kit_id", "cause_id"]).reset_index(drop=True),
        matchup.sort_values(
            ["kit_id_killer", "kit_id_victim", "cause_id"]
        ).reset_index(drop=True),
        death_metrics.sort_values("kit_id").reset_index(drop=True),
    )


def _build_damage_cause_tables(
    damage_received: pd.DataFrame,
    attributed_damage: pd.DataFrame,
    all_kits: pd.DataFrame,
    kit_exposure: pd.DataFrame,
    damage_cause_names: pd.DataFrame,
) -> tuple[
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
]:
    """Build offensive, defensive, and matchup damage tables."""

    damage_with_kit = damage_received.loc[
        damage_received["kit_id_target"].isin(KIT_ID_TO_NAME)
    ].copy()
    cause_ids = sorted(
        set(attributed_damage["cause_id"])
        | set(damage_with_kit["cause_id"])
    )
    damage_causes = damage_cause_names.loc[
        damage_cause_names["cause_id"].isin(cause_ids),
        list(DAMAGE_CAUSE_COLUMNS),
    ].copy()
    cause_grid = all_kits.merge(damage_causes, how="cross")
    exposure_context = kit_exposure[
        ["kit_id", "total_hours", "completed_lives"]
    ]

    outgoing_counts = (
        attributed_damage.groupby(
            ["kit_id_source", "cause_id"], as_index=False
        )["damage_received"]
        .sum()
        .rename(
            columns={
                "kit_id_source": "kit_id",
                "damage_received": "damage_dealt",
            }
        )
    )
    outgoing = (
        cause_grid.merge(
            outgoing_counts,
            on=["kit_id", "cause_id"],
            how="left",
        )
        .merge(exposure_context, on="kit_id", how="left")
        .fillna({"damage_dealt": 0.0})
    )
    outgoing["kit_total_damage_dealt"] = outgoing.groupby("kit_id")[
        "damage_dealt"
    ].transform("sum")
    outgoing["cause_share_of_kit_damage_dealt"] = _safe_divide(
        outgoing["damage_dealt"], outgoing["kit_total_damage_dealt"]
    )
    outgoing["cause_damage_dealt_per_hour"] = _safe_divide(
        outgoing["damage_dealt"], outgoing["total_hours"]
    )
    outgoing["kit_damage_dealt_per_hour"] = _safe_divide(
        outgoing["kit_total_damage_dealt"], outgoing["total_hours"]
    )
    outgoing["cause_damage_dealt_per_completed_life"] = _safe_divide(
        outgoing["damage_dealt"], outgoing["completed_lives"]
    )

    incoming_counts = (
        damage_with_kit.groupby(
            ["kit_id_target", "cause_id"], as_index=False
        )["damage_received"]
        .sum()
        .rename(columns={"kit_id_target": "kit_id"})
    )
    incoming = (
        cause_grid.merge(
            incoming_counts,
            on=["kit_id", "cause_id"],
            how="left",
        )
        .merge(exposure_context, on="kit_id", how="left")
        .fillna({"damage_received": 0.0})
    )
    incoming["kit_total_damage_received"] = incoming.groupby("kit_id")[
        "damage_received"
    ].transform("sum")
    incoming["cause_share_of_kit_damage_received"] = _safe_divide(
        incoming["damage_received"],
        incoming["kit_total_damage_received"],
    )
    incoming["cause_damage_received_per_hour"] = _safe_divide(
        incoming["damage_received"], incoming["total_hours"]
    )
    incoming["cause_damage_received_per_completed_life"] = _safe_divide(
        incoming["damage_received"], incoming["completed_lives"]
    )

    total_damage_dealt = (
        attributed_damage.groupby("kit_id_source", as_index=False)[
            "damage_received"
        ]
        .sum()
        .rename(
            columns={
                "kit_id_source": "kit_id",
                "damage_received": "damage_dealt",
            }
        )
    )
    total_damage_received = (
        damage_with_kit.groupby("kit_id_target", as_index=False)[
            "damage_received"
        ]
        .sum()
        .rename(columns={"kit_id_target": "kit_id"})
    )
    player_damage_received = (
        damage_with_kit.loc[
            damage_with_kit["kit_id_source"].isin(KIT_ID_TO_NAME)
        ]
        .groupby("kit_id_target", as_index=False)["damage_received"]
        .sum()
        .rename(
            columns={
                "kit_id_target": "kit_id",
                "damage_received": "player_damage_received",
            }
        )
    )
    damage_metrics = (
        all_kits.merge(total_damage_dealt, on="kit_id", how="left")
        .merge(total_damage_received, on="kit_id", how="left")
        .merge(player_damage_received, on="kit_id", how="left")
        .merge(exposure_context, on="kit_id", how="left")
        .fillna(
            {
                "damage_dealt": 0.0,
                "damage_received": 0.0,
                "player_damage_received": 0.0,
            }
        )
    )
    damage_metrics["non_player_damage_received"] = (
        damage_metrics["damage_received"]
        - damage_metrics["player_damage_received"]
    ).clip(lower=0)
    damage_metrics["damage_dealt_per_hour"] = _safe_divide(
        damage_metrics["damage_dealt"], damage_metrics["total_hours"]
    )
    damage_metrics["damage_received_per_hour"] = _safe_divide(
        damage_metrics["damage_received"], damage_metrics["total_hours"]
    )
    damage_metrics["player_damage_received_per_hour"] = _safe_divide(
        damage_metrics["player_damage_received"],
        damage_metrics["total_hours"],
    )
    damage_metrics["non_player_damage_received_per_hour"] = _safe_divide(
        damage_metrics["non_player_damage_received"],
        damage_metrics["total_hours"],
    )
    damage_metrics["damage_dealt_per_completed_life"] = _safe_divide(
        damage_metrics["damage_dealt"], damage_metrics["completed_lives"]
    )
    damage_metrics["damage_received_per_completed_life"] = _safe_divide(
        damage_metrics["damage_received"],
        damage_metrics["completed_lives"],
    )
    damage_metrics["damage_exchange_ratio"] = _safe_divide(
        damage_metrics["damage_dealt"],
        damage_metrics["player_damage_received"],
    )
    damage_metrics["player_damage_received_share"] = _safe_divide(
        damage_metrics["player_damage_received"],
        damage_metrics["damage_received"],
    )
    damage_metrics["non_player_damage_received_share"] = _safe_divide(
        damage_metrics["non_player_damage_received"],
        damage_metrics["damage_received"],
    )

    incoming = incoming.merge(
        damage_metrics[
            [
                "kit_id",
                "damage_received_per_hour",
                "player_damage_received",
                "non_player_damage_received",
                "non_player_damage_received_share",
            ]
        ].rename(
            columns={
                "damage_received_per_hour": (
                    "kit_damage_received_per_hour"
                )
            }
        ),
        on="kit_id",
        how="left",
    )

    matchup = (
        attributed_damage.groupby(
            ["kit_id_source", "kit_id_target", "cause_id"],
            as_index=False,
        )["damage_received"]
        .sum()
        .merge(damage_causes, on="cause_id", how="left")
    )
    matchup["source_kit_name"] = matchup["kit_id_source"].map(
        KIT_ID_TO_NAME
    )
    matchup["target_kit_name"] = matchup["kit_id_target"].map(
        KIT_ID_TO_NAME
    )

    return (
        damage_causes.sort_values("cause_id").reset_index(drop=True),
        outgoing.sort_values(["kit_id", "cause_id"]).reset_index(drop=True),
        incoming.sort_values(["kit_id", "cause_id"]).reset_index(drop=True),
        matchup.sort_values(
            ["kit_id_source", "kit_id_target", "cause_id"]
        ).reset_index(drop=True),
        damage_metrics.sort_values("kit_id").reset_index(drop=True),
    )


def _build_player_kit_metrics(
    player_kit_exposure: pd.DataFrame,
    player_kit_kills: pd.DataFrame,
    player_kit_abilities: pd.DataFrame,
    player_kit_damage_dealt: pd.DataFrame,
    kit_settings: pd.DataFrame,
) -> pd.DataFrame:
    kills = player_kit_kills.rename(columns={"id_killer": "id"})[
        ["id", "kit_id", "kills"]
    ]
    abilities = player_kit_abilities[["id", "kit_id", "ability_use"]]
    damage = player_kit_damage_dealt.rename(columns={"id_source": "id"})[
        ["id", "kit_id", "damage_dealt"]
    ]
    exposure_columns = [
        "id",
        "kit_id",
        "kit_name",
        "total_time",
        "total_hours",
        "completed_lives",
        "time_share_within_player",
        "completed_life_share_within_player",
        "player_time_share_of_kit",
        "player_completed_life_share_of_kit",
        "time_per_completed_life",
        "hours_per_completed_life",
    ]
    keys = pd.concat(
        [
            player_kit_exposure[["id", "kit_id"]],
            kills[["id", "kit_id"]],
            abilities[["id", "kit_id"]],
            damage[["id", "kit_id"]],
        ],
        ignore_index=True,
    ).drop_duplicates()
    metrics = (
        keys.merge(
            player_kit_exposure[exposure_columns],
            on=["id", "kit_id"],
            how="left",
        )
        .merge(kills, on=["id", "kit_id"], how="left")
        .merge(abilities, on=["id", "kit_id"], how="left")
        .merge(damage, on=["id", "kit_id"], how="left")
        .merge(
            kit_settings[
                [
                    "kit_id",
                    "ability_cooldown",
                    "ability_cooldown_seconds",
                    "theoretical_ability_uses_per_hour",
                ]
            ],
            on="kit_id",
            how="left",
            validate="many_to_one",
        )
    )
    metrics["kit_name"] = metrics["kit_name"].fillna(
        metrics["kit_id"].map(KIT_ID_TO_NAME)
    )
    zero_columns = (
        "total_time",
        "total_hours",
        "completed_lives",
        "kills",
        "ability_use",
        "damage_dealt",
    )
    metrics[list(zero_columns)] = metrics[list(zero_columns)].fillna(0)
    metrics[["total_time", "completed_lives", "kills", "ability_use"]] = (
        metrics[["total_time", "completed_lives", "kills", "ability_use"]]
        .astype(int)
    )

    metrics["kills_per_hour"] = _safe_divide(
        metrics["kills"], metrics["total_hours"]
    )
    metrics["kills_per_completed_life"] = _safe_divide(
        metrics["kills"], metrics["completed_lives"]
    )
    metrics["ability_uses_per_hour"] = _safe_divide(
        metrics["ability_use"], metrics["total_hours"]
    )
    metrics["ability_uses_per_completed_life"] = _safe_divide(
        metrics["ability_use"], metrics["completed_lives"]
    )
    metrics["cooldown_normalized_use_rate"] = _safe_divide(
        metrics["ability_uses_per_hour"],
        metrics["theoretical_ability_uses_per_hour"],
    )
    metrics["damage_dealt_per_hour"] = _safe_divide(
        metrics["damage_dealt"], metrics["total_hours"]
    )
    metrics["damage_dealt_per_completed_life"] = _safe_divide(
        metrics["damage_dealt"], metrics["completed_lives"]
    )

    kit_kills = metrics.groupby("kit_id")["kills"].transform("sum")
    kit_abilities = metrics.groupby("kit_id")["ability_use"].transform("sum")
    kit_damage = metrics.groupby("kit_id")["damage_dealt"].transform("sum")
    metrics["player_kill_share_of_kit"] = _safe_divide(
        metrics["kills"], kit_kills
    )
    metrics["player_ability_use_share_of_kit"] = _safe_divide(
        metrics["ability_use"], kit_abilities
    )
    metrics["player_damage_share_of_kit"] = _safe_divide(
        metrics["damage_dealt"], kit_damage
    )
    metrics["kill_share_minus_time_share"] = (
        metrics["player_kill_share_of_kit"]
        - metrics["player_time_share_of_kit"]
    )
    metrics["kill_to_time_share_ratio"] = _safe_divide(
        metrics["player_kill_share_of_kit"],
        metrics["player_time_share_of_kit"],
    )
    metrics["ability_use_to_time_share_ratio"] = _safe_divide(
        metrics["player_ability_use_share_of_kit"],
        metrics["player_time_share_of_kit"],
    )
    metrics["damage_share_minus_time_share"] = (
        metrics["player_damage_share_of_kit"]
        - metrics["player_time_share_of_kit"]
    )
    metrics["damage_to_time_share_ratio"] = _safe_divide(
        metrics["player_damage_share_of_kit"],
        metrics["player_time_share_of_kit"],
    )
    return metrics.sort_values(["kit_id", "id"]).reset_index(drop=True)


def _build_player_rate_stats(
    player_kit_metrics: pd.DataFrame,
    all_kits: pd.DataFrame,
) -> pd.DataFrame:
    specs = {
        "kills_per_hour": "players_with_kill_rate_per_hour",
        "kills_per_completed_life": "players_with_kill_rate_per_life",
        "ability_uses_per_hour": "players_with_ability_rate_per_hour",
        "cooldown_normalized_use_rate": (
            "players_with_cooldown_normalized_use_rate"
        ),
        "ability_uses_per_completed_life": (
            "players_with_ability_rate_per_life"
        ),
        "damage_dealt_per_hour": "players_with_damage_rate_per_hour",
        "damage_dealt_per_completed_life": (
            "players_with_damage_rate_per_life"
        ),
        "hours_per_completed_life": "players_with_life_duration",
    }
    stats = all_kits.copy()
    for metric, count_column in specs.items():
        observed = (
            player_kit_metrics.loc[player_kit_metrics[metric].notna()]
            .groupby("kit_id")[metric]
            .agg(["median", "count"])
            .rename(
                columns={
                    "median": f"median_player_{metric}",
                    "count": count_column,
                }
            )
        )
        stats = stats.merge(observed, on="kit_id", how="left")
        stats[count_column] = stats[count_column].fillna(0).astype(int)
    return stats


def _build_kit_metrics(
    all_kits: pd.DataFrame,
    total_kills_by_kit: pd.DataFrame,
    total_abilities_by_kit: pd.DataFrame,
    kit_exposure: pd.DataFrame,
    player_rate_stats: pd.DataFrame,
    kit_settings: pd.DataFrame,
    death_metrics: pd.DataFrame,
    damage_metrics: pd.DataFrame,
) -> pd.DataFrame:
    metrics = (
        all_kits.merge(
            kit_settings.drop(columns="kit_name"),
            on="kit_id",
            how="left",
            validate="one_to_one",
        )
        .merge(
            total_kills_by_kit[["kit_id", "kills"]],
            on="kit_id",
            how="left",
        )
        .merge(
            total_abilities_by_kit[["kit_id", "ability_use"]],
            on="kit_id",
            how="left",
        )
        .merge(
            kit_exposure.drop(columns="kit_name"),
            on="kit_id",
            how="left",
        )
        .merge(
            death_metrics[
                [
                    "kit_id",
                    "deaths",
                    "player_caused_deaths",
                    "non_player_deaths",
                    "deaths_per_hour",
                    "deaths_per_completed_life",
                    "player_caused_death_share",
                    "non_player_death_share",
                ]
            ],
            on="kit_id",
            how="left",
        )
        .merge(
            damage_metrics[
                [
                    "kit_id",
                    "damage_dealt",
                    "damage_received",
                    "player_damage_received",
                    "non_player_damage_received",
                    "damage_dealt_per_hour",
                    "damage_received_per_hour",
                    "player_damage_received_per_hour",
                    "non_player_damage_received_per_hour",
                    "damage_dealt_per_completed_life",
                    "damage_received_per_completed_life",
                    "damage_exchange_ratio",
                    "player_damage_received_share",
                    "non_player_damage_received_share",
                ]
            ],
            on="kit_id",
            how="left",
        )
        .merge(
            player_rate_stats.drop(columns="kit_name"),
            on="kit_id",
            how="left",
        )
    )
    count_columns = [
        "kills",
        "ability_use",
        "deaths",
        "player_caused_deaths",
        "non_player_deaths",
    ]
    metrics[count_columns] = metrics[count_columns].fillna(0).astype(int)
    metrics["kill_share"] = _safe_divide(
        metrics["kills"],
        pd.Series(metrics["kills"].sum(), index=metrics.index),
    )
    metrics["ability_use_share"] = _safe_divide(
        metrics["ability_use"],
        pd.Series(metrics["ability_use"].sum(), index=metrics.index),
    )
    metrics["damage_share"] = _safe_divide(
        metrics["damage_dealt"],
        pd.Series(metrics["damage_dealt"].sum(), index=metrics.index),
    )
    metrics["kills_per_hour"] = _safe_divide(
        metrics["kills"], metrics["total_hours"]
    )
    metrics["kills_per_completed_life"] = _safe_divide(
        metrics["kills"], metrics["completed_lives"]
    )
    metrics["kill_death_ratio"] = _safe_divide(
        metrics["kills"], metrics["deaths"]
    )
    metrics["kills_per_player_caused_death"] = _safe_divide(
        metrics["kills"], metrics["player_caused_deaths"]
    )
    metrics["ability_uses_per_hour"] = _safe_divide(
        metrics["ability_use"], metrics["total_hours"]
    )
    metrics["ability_uses_per_completed_life"] = _safe_divide(
        metrics["ability_use"], metrics["completed_lives"]
    )
    metrics["cooldown_normalized_use_rate"] = _safe_divide(
        metrics["ability_uses_per_hour"],
        metrics["theoretical_ability_uses_per_hour"],
    )
    metrics["damage_dealt_per_kill"] = _safe_divide(
        metrics["damage_dealt"], metrics["kills"]
    )
    metrics["kill_share_minus_time_share"] = (
        metrics["kill_share"] - metrics["time_share"]
    )
    metrics["kill_to_time_share_ratio"] = _safe_divide(
        metrics["kill_share"], metrics["time_share"]
    )
    metrics["ability_use_to_time_share_ratio"] = _safe_divide(
        metrics["ability_use_share"], metrics["time_share"]
    )
    metrics["damage_share_minus_time_share"] = (
        metrics["damage_share"] - metrics["time_share"]
    )
    metrics["damage_to_time_share_ratio"] = _safe_divide(
        metrics["damage_share"], metrics["time_share"]
    )
    return metrics.sort_values("kit_id").reset_index(drop=True)


def _build_top_killer_exposure(
    player_kit_metrics: pd.DataFrame,
    kit_metrics: pd.DataFrame,
) -> pd.DataFrame:
    """Pair each kit's top killer with that same player's exposure share."""

    output_columns = [
        "kit_id",
        "kit_name",
        "top_killer_id",
        "top_killer_kills",
        "top_killer_hours",
        "top_killer_completed_lives",
        "top_killer_kills_per_hour",
        "top_killer_kills_per_completed_life",
        "top_killer_kill_share",
        "top_killer_time_share",
        "top_killer_kill_share_minus_time_share",
        "top_killer_kill_to_time_share_ratio",
        "kit_kills",
        "kit_total_hours",
        "kit_completed_lives",
        "kit_players_with_time",
    ]
    active = player_kit_metrics.loc[
        player_kit_metrics["kills"] > 0
    ].copy()
    if active.empty:
        return pd.DataFrame(columns=output_columns)

    # A deterministic ID tie-breaker only matters when multiple players have
    # the same maximum kill count; their kill shares are then identical.
    top_killers = (
        active.sort_values(
            ["kit_id", "kills", "id"],
            ascending=[True, False, True],
            kind="stable",
        )
        .drop_duplicates("kit_id", keep="first")
        [
            [
                "kit_id",
                "kit_name",
                "id",
                "kills",
                "total_hours",
                "completed_lives",
                "kills_per_hour",
                "kills_per_completed_life",
                "player_kill_share_of_kit",
                "player_time_share_of_kit",
                "kill_share_minus_time_share",
                "kill_to_time_share_ratio",
            ]
        ]
        .rename(
            columns={
                "id": "top_killer_id",
                "kills": "top_killer_kills",
                "total_hours": "top_killer_hours",
                "completed_lives": "top_killer_completed_lives",
                "kills_per_hour": "top_killer_kills_per_hour",
                "kills_per_completed_life": (
                    "top_killer_kills_per_completed_life"
                ),
                "player_kill_share_of_kit": "top_killer_kill_share",
                "player_time_share_of_kit": "top_killer_time_share",
                "kill_share_minus_time_share": (
                    "top_killer_kill_share_minus_time_share"
                ),
                "kill_to_time_share_ratio": (
                    "top_killer_kill_to_time_share_ratio"
                ),
            }
        )
    )
    kit_context = kit_metrics[
        [
            "kit_id",
            "kills",
            "total_hours",
            "completed_lives",
            "players_with_time",
        ]
    ].rename(
        columns={
            "kills": "kit_kills",
            "total_hours": "kit_total_hours",
            "completed_lives": "kit_completed_lives",
            "players_with_time": "kit_players_with_time",
        }
    )
    result = top_killers.merge(kit_context, on="kit_id", how="left")
    return result[output_columns].sort_values("kit_id").reset_index(drop=True)


def _build_reach(
    player_kit_kills: pd.DataFrame,
    player_kit_abilities: pd.DataFrame,
    player_kit_exposure: pd.DataFrame,
    n_players: int,
) -> pd.DataFrame:
    players_with_time = (
        player_kit_exposure.loc[player_kit_exposure["total_time"] > 0]
        .groupby("kit_id")["id"]
        .nunique()
        .reindex(range(len(KIT_NAMES)), fill_value=0)
    )
    players_with_kill = (
        player_kit_kills.loc[player_kit_kills["kills"] > 0]
        .groupby("kit_id")["id_killer"]
        .nunique()
        .reindex(range(len(KIT_NAMES)), fill_value=0)
    )
    players_with_ability = (
        player_kit_abilities.loc[player_kit_abilities["ability_use"] > 0]
        .groupby("kit_id")["id"]
        .nunique()
        .reindex(range(len(KIT_NAMES)), fill_value=0)
    )

    if n_players:
        played_proportion = players_with_time / n_players
        kill_proportion = players_with_kill / n_players
        ability_proportion = players_with_ability / n_players
    else:
        played_proportion = players_with_time.astype(float) * np.nan
        kill_proportion = players_with_kill.astype(float) * np.nan
        ability_proportion = players_with_ability.astype(float) * np.nan

    return pd.DataFrame(
        {
            "kit_name": KIT_ORDER,
            "played": played_proportion.to_numpy(),
            "used_ability": ability_proportion.to_numpy(),
            "made_kill": kill_proportion.to_numpy(),
            "played_count": players_with_time.to_numpy(),
            "used_ability_count": players_with_ability.to_numpy(),
            "made_kill_count": players_with_kill.to_numpy(),
        }
    )


def _safe_divide(
    numerator: pd.Series,
    denominator: pd.Series,
) -> pd.Series:
    """Divide aligned series and use NaN when the denominator is not positive."""

    numerator = pd.to_numeric(numerator, errors="coerce").astype(float)
    denominator = pd.to_numeric(denominator, errors="coerce").astype(float)
    result = pd.Series(np.nan, index=numerator.index, dtype=float)
    valid = denominator > 0
    result.loc[valid] = numerator.loc[valid] / denominator.loc[valid]
    return result

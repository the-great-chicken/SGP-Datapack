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
    "id_victim",
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
ABILITY_COLUMNS = (
    "id",
    "kit_id",
    "ability_path",
    "metric_id",
    "value",
)
PICK_COLUMNS = ("id", "kit_id", "total_time", "nbr_picks")
ABILITY_METADATA_COLUMNS = (
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
)
DAMAGE_CAUSE_COLUMNS = ("cause_id", "cause_name")
ELO_METADATA_COLUMNS = (
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
)
ELO_RATING_COLUMNS = ("id", "rating", "rated_encounters")

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
    ability_metadata: pd.DataFrame
    elo_metadata: pd.DataFrame
    elo_ratings: pd.DataFrame
    picks: pd.DataFrame
    # One derived row per kit. Kept as ``kit_settings`` so the established
    # cooldown-based calculations and public ReportData attribute stay stable.
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
    player_elo: pd.DataFrame
    player_kit_exposure: pd.DataFrame
    kit_exposure: pd.DataFrame
    kit_elo_context: pd.DataFrame
    elo_kill_results: pd.DataFrame
    elo_matchup_expected_share: np.ndarray
    elo_matchup_score_difference: np.ndarray
    elo_matchup_pair_totals: np.ndarray
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


def _build_player_elo(
    player_ids: set[str],
    elo_metadata: pd.DataFrame,
    elo_ratings: pd.DataFrame,
    kills: pd.DataFrame,
) -> pd.DataFrame:
    """Complete the Elo snapshot for every player observed in report data."""

    players = pd.DataFrame(
        {"id": pd.Series(sorted(player_ids), dtype=str)}
    )
    if elo_metadata.empty:
        players["rating"] = np.nan
        players["rated_encounters"] = pd.Series(
            pd.NA,
            index=players.index,
            dtype="Int64",
        )
        players["elo_rating_recorded"] = False
        return players

    initial_rating = float(elo_metadata["initial_rating"].iloc[0])
    players = players.merge(
        elo_ratings,
        on="id",
        how="left",
        validate="one_to_one",
        indicator=True,
    )
    players["elo_rating_recorded"] = players["_merge"].eq("both")
    players = players.drop(columns="_merge")
    players["rating"] = players["rating"].fillna(initial_rating).astype(float)
    players["rated_encounters"] = (
        players["rated_encounters"].fillna(0).astype(int)
    )

    rated_lookup = players.set_index("id")["rated_encounters"]
    rated_kills = kills.loc[
        (kills["kills"] > 0)
        & kills["kit_id_killer"].isin(KIT_ID_TO_NAME)
        & kills["kit_id_victim"].isin(KIT_ID_TO_NAME)
        & kills["id_killer"].ne(NO_PLAYER_ID)
        & kills["id_victim"].ne(NO_PLAYER_ID)
        & kills["id_killer"].ne(kills["id_victim"])
    ]
    credited_participants = set(rated_kills["id_killer"]) | set(
        rated_kills["id_victim"]
    )
    invalid_participants = sorted(
        player_id
        for player_id in credited_participants
        if player_id not in rated_lookup.index
        or int(rated_lookup.loc[player_id]) <= 0
    )
    if invalid_participants:
        raise ValueError(
            "Players in credited PvP kill results must have rated "
            f"encounters: {invalid_participants}"
        )
    return players


def _build_elo_kill_context(
    attributed_kills: pd.DataFrame,
    player_elo: pd.DataFrame,
    elo_metadata: pd.DataFrame,
    all_kits: pd.DataFrame,
) -> tuple[pd.DataFrame, np.ndarray, np.ndarray, np.ndarray]:
    """Compare cross-kit kill results with the current Elo snapshot.

    Each credited PvP kill contributes one observed score of 1 to the killer
    and 0 to the victim. The corresponding expected scores use the configured
    logistic Elo formula and both players' ratings at extraction time. These
    are deliberately described as *current-Elo-implied* results: the extract
    does not contain the pre-kill rating snapshots needed to reconstruct the
    historical expectation of each encounter.

    Same-kit results are excluded because they necessarily add one win and one
    loss to the same kit and therefore carry no kit-balance signal.
    """

    output = all_kits.copy()
    count_columns = (
        "cross_kit_kills",
        "cross_kit_deaths",
        "cross_kit_results",
        "players_in_cross_kit_results",
    )
    metric_columns = (
        "observed_cross_kit_score_rate",
        "current_elo_implied_score_rate",
        "score_rate_minus_current_elo",
        "current_elo_implied_score_sum",
        "score_sum_minus_current_elo",
    )
    for column in count_columns:
        output[column] = 0
    for column in metric_columns:
        output[column] = np.nan

    shape = (len(KIT_NAMES), len(KIT_NAMES))
    expected_share = np.full(shape, np.nan, dtype=float)
    score_difference = np.full(shape, np.nan, dtype=float)
    pair_totals = np.zeros(shape, dtype=int)
    if elo_metadata.empty:
        return output, expected_share, score_difference, pair_totals

    algorithm = str(elo_metadata["algorithm"].iloc[0])
    if algorithm != "elo_logistic":
        raise ValueError(
            "Current-Elo kill comparisons require algorithm "
            f"'elo_logistic'; found {algorithm!r}"
        )
    result_type = str(elo_metadata["result_type"].iloc[0])
    if result_type != "credited_pvp_kill":
        raise ValueError(
            "Current-Elo kill comparisons require result_type "
            f"'credited_pvp_kill'; found {result_type!r}"
        )

    results = attributed_kills.loc[
        (attributed_kills["kills"] > 0)
        & attributed_kills["id_killer"].ne(NO_PLAYER_ID)
        & attributed_kills["id_victim"].ne(NO_PLAYER_ID)
        & attributed_kills["id_killer"].ne(attributed_kills["id_victim"])
        & attributed_kills["kit_id_killer"].ne(
            attributed_kills["kit_id_victim"]
        )
    ].copy()
    if results.empty:
        return output, expected_share, score_difference, pair_totals

    rating_lookup = player_elo[
        ["id", "rating", "rated_encounters"]
    ]
    results = (
        results.merge(
            rating_lookup.rename(
                columns={
                    "id": "id_killer",
                    "rating": "killer_rating",
                    "rated_encounters": "killer_rated_encounters",
                }
            ),
            on="id_killer",
            how="left",
            validate="many_to_one",
        )
        .merge(
            rating_lookup.rename(
                columns={
                    "id": "id_victim",
                    "rating": "victim_rating",
                    "rated_encounters": "victim_rated_encounters",
                }
            ),
            on="id_victim",
            how="left",
            validate="many_to_one",
        )
    )
    required_rating_columns = [
        "killer_rating",
        "victim_rating",
        "killer_rated_encounters",
        "victim_rated_encounters",
    ]
    if results[required_rating_columns].isna().any().any():
        raise ValueError(
            "Credited PvP kill results reference players missing from the "
            "Elo snapshot"
        )
    if (
        (results["killer_rated_encounters"] <= 0)
        | (results["victim_rated_encounters"] <= 0)
    ).any():
        raise ValueError(
            "Credited PvP kill results require positive rated encounters "
            "for both players"
        )

    rating_divisor = float(elo_metadata["rating_divisor"].iloc[0])
    rating_gap = (
        results["victim_rating"] - results["killer_rating"]
    ) / rating_divisor
    # Clipping only protects the floating-point exponent at implausibly large
    # rating gaps; it has no practical effect on ordinary Elo values.
    odds = np.power(10.0, np.clip(rating_gap, -300.0, 300.0))
    results["killer_current_elo_expected_score"] = 1.0 / (1.0 + odds)
    results["victim_current_elo_expected_score"] = (
        1.0 - results["killer_current_elo_expected_score"]
    )

    killer_sides = pd.DataFrame(
        {
            "id": results["id_killer"],
            "kit_id": results["kit_id_killer"],
            "cross_kit_kills": results["kills"],
            "cross_kit_deaths": 0,
            "cross_kit_results": results["kills"],
            "observed_score_sum": results["kills"],
            "current_elo_implied_score_sum": (
                results["kills"]
                * results["killer_current_elo_expected_score"]
            ),
        }
    )
    victim_sides = pd.DataFrame(
        {
            "id": results["id_victim"],
            "kit_id": results["kit_id_victim"],
            "cross_kit_kills": 0,
            "cross_kit_deaths": results["kills"],
            "cross_kit_results": results["kills"],
            "observed_score_sum": 0,
            "current_elo_implied_score_sum": (
                results["kills"]
                * results["victim_current_elo_expected_score"]
            ),
        }
    )
    sides = pd.concat([killer_sides, victim_sides], ignore_index=True)
    totals = sides.groupby("kit_id", as_index=False).agg(
        cross_kit_kills=("cross_kit_kills", "sum"),
        cross_kit_deaths=("cross_kit_deaths", "sum"),
        cross_kit_results=("cross_kit_results", "sum"),
        observed_score_sum=("observed_score_sum", "sum"),
        current_elo_implied_score_sum=(
            "current_elo_implied_score_sum",
            "sum",
        ),
        players_in_cross_kit_results=("id", "nunique"),
    )
    totals["observed_cross_kit_score_rate"] = _safe_divide(
        totals["observed_score_sum"], totals["cross_kit_results"]
    )
    totals["current_elo_implied_score_rate"] = _safe_divide(
        totals["current_elo_implied_score_sum"],
        totals["cross_kit_results"],
    )
    totals["score_rate_minus_current_elo"] = (
        totals["observed_cross_kit_score_rate"]
        - totals["current_elo_implied_score_rate"]
    )
    totals["score_sum_minus_current_elo"] = (
        totals["observed_score_sum"]
        - totals["current_elo_implied_score_sum"]
    )
    output = all_kits.merge(
        totals.drop(columns="observed_score_sum"),
        on="kit_id",
        how="left",
        validate="one_to_one",
    )
    output[list(count_columns)] = output[list(count_columns)].fillna(0).astype(
        int
    )

    observed_scores = np.zeros(shape, dtype=float)
    expected_scores = np.zeros(shape, dtype=float)
    for row in results.itertuples(index=False):
        killer_kit = int(row.kit_id_killer)
        victim_kit = int(row.kit_id_victim)
        result_count = int(row.kills)
        observed_scores[killer_kit, victim_kit] += result_count
        expected_scores[killer_kit, victim_kit] += (
            result_count * row.killer_current_elo_expected_score
        )
        expected_scores[victim_kit, killer_kit] += (
            result_count * row.victim_current_elo_expected_score
        )
        pair_totals[killer_kit, victim_kit] += result_count
        pair_totals[victim_kit, killer_kit] += result_count

    observed_share = np.full(shape, np.nan, dtype=float)
    np.divide(
        observed_scores,
        pair_totals,
        out=observed_share,
        where=pair_totals > 0,
    )
    np.divide(
        expected_scores,
        pair_totals,
        out=expected_share,
        where=pair_totals > 0,
    )
    score_difference = observed_share - expected_share
    np.fill_diagonal(expected_share, np.nan)
    np.fill_diagonal(score_difference, np.nan)
    np.fill_diagonal(pair_totals, 0)
    return (
        output.sort_values("kit_id").reset_index(drop=True),
        expected_share,
        score_difference,
        pair_totals,
    )


def _build_kit_elo_context(
    player_kit_exposure: pd.DataFrame,
    player_elo: pd.DataFrame,
    all_kits: pd.DataFrame,
) -> pd.DataFrame:
    """Summarize the Elo composition behind each kit's observed playtime."""

    output = all_kits.copy()
    metric_columns = (
        "playtime_weighted_player_elo",
        "overall_playtime_weighted_player_elo",
        "player_elo_difference_from_overall",
        "rated_player_time_share",
        "players_with_rated_encounters",
        "median_player_rated_encounters",
    )
    if player_kit_exposure.empty or player_elo["rating"].notna().sum() == 0:
        for column in metric_columns:
            output[column] = np.nan
        output["players_with_rated_encounters"] = 0
        return output

    exposure = player_kit_exposure.loc[
        player_kit_exposure["total_time"] > 0
    ].merge(
        player_elo[["id", "rating", "rated_encounters"]],
        on="id",
        how="left",
        validate="many_to_one",
    )
    exposure["weighted_rating"] = exposure["total_time"] * exposure["rating"]
    exposure["rated_time"] = exposure["total_time"].where(
        exposure["rated_encounters"] > 0,
        0,
    )
    totals = exposure.groupby("kit_id", as_index=False).agg(
        elo_weighted_rating_sum=("weighted_rating", "sum"),
        elo_total_time=("total_time", "sum"),
        elo_rated_time=("rated_time", "sum"),
        players_with_rated_encounters=(
            "rated_encounters",
            lambda values: int((values > 0).sum()),
        ),
        median_player_rated_encounters=("rated_encounters", "median"),
    )
    totals["playtime_weighted_player_elo"] = _safe_divide(
        totals["elo_weighted_rating_sum"],
        totals["elo_total_time"],
    )
    totals["rated_player_time_share"] = _safe_divide(
        totals["elo_rated_time"],
        totals["elo_total_time"],
    )
    overall_total_time = float(totals["elo_total_time"].sum())
    overall_rating = (
        float(totals["elo_weighted_rating_sum"].sum()) / overall_total_time
        if overall_total_time > 0
        else np.nan
    )
    totals["overall_playtime_weighted_player_elo"] = overall_rating
    totals["player_elo_difference_from_overall"] = (
        totals["playtime_weighted_player_elo"] - overall_rating
    )
    output = output.merge(
        totals[["kit_id", *metric_columns]],
        on="kit_id",
        how="left",
        validate="one_to_one",
    )
    output["players_with_rated_encounters"] = pd.to_numeric(
        output["players_with_rated_encounters"], errors="coerce"
    ).fillna(0).astype(int)
    return output.sort_values("kit_id").reset_index(drop=True)


def _build_kit_ability_settings(
    ability_metadata: pd.DataFrame,
    all_kits: pd.DataFrame,
) -> pd.DataFrame:
    """Collapse metric metadata to the report's one-ability-per-kit model."""

    timing_columns = [
        "kit_id",
        "ability_path",
        "cooldown_ticks",
        "duration_ticks",
        "settings_json",
    ]
    timing = ability_metadata[timing_columns].drop_duplicates()
    duplicate_timing = timing.duplicated("kit_id", keep=False)
    if duplicate_timing.any():
        invalid = sorted(timing.loc[duplicate_timing, "kit_id"].unique())
        raise ValueError(
            "Inconsistent ability timing/settings metadata for kit IDs: "
            f"{invalid}"
        )

    success_support = (
        ability_metadata.assign(
            supports_success_metric=lambda frame: frame["metric_id"].eq(
                "successful_uses"
            )
        )
        .groupby("kit_id", as_index=False)["supports_success_metric"]
        .any()
    )
    effect = ability_metadata.loc[
        ~ability_metadata["metric_id"].isin({"uses", "successful_uses"}),
        [
            "kit_id",
            "ability_path",
            "metric_id",
            "metric_name",
            "description",
            "display_unit",
            "source_type",
        ],
    ].rename(
        columns={
            "metric_id": "ability_effect_metric_id",
            "metric_name": "ability_effect_metric_name",
            "description": "ability_effect_description",
            "display_unit": "ability_effect_unit",
            "source_type": "ability_effect_source_type",
        }
    )

    settings = (
        all_kits.merge(timing, on="kit_id", how="left", validate="one_to_one")
        .merge(success_support, on="kit_id", how="left", validate="one_to_one")
        .merge(
            effect.drop(columns="ability_path"),
            on="kit_id",
            how="left",
            validate="one_to_one",
        )
        .rename(
            columns={
                "cooldown_ticks": "ability_cooldown",
                "duration_ticks": "ability_duration",
            }
        )
    )
    settings["ability_name"] = (
        settings["ability_path"].str.replace("_", " ").str.title()
    )
    settings["supports_success_metric"] = settings[
        "supports_success_metric"
    ].fillna(False).astype(bool)
    settings["supports_effect_metric"] = settings[
        "ability_effect_metric_id"
    ].notna()
    return settings.sort_values("kit_id").reset_index(drop=True)


def _build_ability_tables(
    abilities: pd.DataFrame,
    all_kits: pd.DataFrame,
    kit_settings: pd.DataFrame,
) -> tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    """Build canonical use, success, and kit-specific effect tables."""

    descriptor_columns = [
        "kit_id",
        "ability_path",
        "ability_name",
        "supports_success_metric",
        "supports_effect_metric",
        "ability_effect_metric_id",
        "ability_effect_metric_name",
        "ability_effect_description",
        "ability_effect_unit",
        "ability_effect_source_type",
    ]
    keys = abilities[["id", "kit_id"]].drop_duplicates()
    player_metrics = keys.merge(
        kit_settings[descriptor_columns],
        on="kit_id",
        how="left",
        validate="many_to_one",
    )

    def metric_values(metric_id: str, value_name: str) -> pd.DataFrame:
        return abilities.loc[
            abilities["metric_id"].eq(metric_id),
            ["id", "kit_id", "value"],
        ].rename(columns={"value": value_name})

    player_metrics = player_metrics.merge(
        metric_values("uses", "ability_use"),
        on=["id", "kit_id"],
        how="left",
        validate="one_to_one",
    ).merge(
        metric_values("successful_uses", "successful_uses"),
        on=["id", "kit_id"],
        how="left",
        validate="one_to_one",
    )

    effect_rows = abilities.merge(
        kit_settings[
            ["kit_id", "ability_effect_metric_id"]
        ],
        left_on=["kit_id", "metric_id"],
        right_on=["kit_id", "ability_effect_metric_id"],
        how="inner",
        validate="many_to_one",
    )[["id", "kit_id", "value"]].rename(
        columns={"value": "ability_effect_value"}
    )
    player_metrics = player_metrics.merge(
        effect_rows,
        on=["id", "kit_id"],
        how="left",
        validate="one_to_one",
    )

    player_metrics["ability_use"] = (
        player_metrics["ability_use"].fillna(0).round().astype(int)
    )
    success_mask = player_metrics["supports_success_metric"]
    player_metrics.loc[success_mask, "successful_uses"] = player_metrics.loc[
        success_mask, "successful_uses"
    ].fillna(0)
    player_metrics.loc[~success_mask, "successful_uses"] = np.nan
    effect_mask = player_metrics["supports_effect_metric"]
    player_metrics.loc[effect_mask, "ability_effect_value"] = (
        player_metrics.loc[effect_mask, "ability_effect_value"].fillna(0.0)
    )
    player_metrics.loc[~effect_mask, "ability_effect_value"] = np.nan
    player_metrics["ability_success_rate"] = _safe_divide(
        player_metrics["successful_uses"], player_metrics["ability_use"]
    )
    player_metrics["ability_effect_per_use"] = _safe_divide(
        player_metrics["ability_effect_value"], player_metrics["ability_use"]
    )
    player_metrics["ability_effect_per_successful_use"] = _safe_divide(
        player_metrics["ability_effect_value"],
        player_metrics["successful_uses"],
    )
    player_metrics["kit_name"] = player_metrics["kit_id"].map(
        KIT_ID_TO_NAME
    )

    aggregated = (
        player_metrics.groupby("kit_id", as_index=False)
        .agg(
            ability_use=("ability_use", "sum"),
            successful_uses=(
                "successful_uses",
                lambda values: values.sum(min_count=1),
            ),
            ability_effect_value=(
                "ability_effect_value",
                lambda values: values.sum(min_count=1),
            ),
            players_with_successful_use=(
                "successful_uses",
                lambda values: int((values.fillna(0) > 0).sum()),
            ),
            players_with_effect=(
                "ability_effect_value",
                lambda values: int((values.fillna(0) > 0).sum()),
            ),
        )
    )
    totals = (
        all_kits.merge(
            kit_settings[descriptor_columns],
            on="kit_id",
            how="left",
            validate="one_to_one",
        )
        .merge(aggregated, on="kit_id", how="left", validate="one_to_one")
    )
    totals["ability_use"] = totals["ability_use"].fillna(0).astype(int)
    for count_column in ("players_with_successful_use", "players_with_effect"):
        totals[count_column] = totals[count_column].fillna(0).astype(int)
    success_mask = totals["supports_success_metric"]
    totals.loc[success_mask, "successful_uses"] = totals.loc[
        success_mask, "successful_uses"
    ].fillna(0)
    totals.loc[~success_mask, "successful_uses"] = np.nan
    effect_mask = totals["supports_effect_metric"]
    totals.loc[effect_mask, "ability_effect_value"] = totals.loc[
        effect_mask, "ability_effect_value"
    ].fillna(0.0)
    totals.loc[~effect_mask, "ability_effect_value"] = np.nan
    totals["ability_success_rate"] = _safe_divide(
        totals["successful_uses"], totals["ability_use"]
    )
    totals["ability_effect_per_use"] = _safe_divide(
        totals["ability_effect_value"], totals["ability_use"]
    )
    totals["ability_effect_per_successful_use"] = _safe_divide(
        totals["ability_effect_value"], totals["successful_uses"]
    )

    ability_concentration = _concentration_from_counts(
        player_metrics,
        group_col="kit_id",
        value_col="ability_use",
    ).rename(
        columns={
            "players": "players_using_ability",
            "top_player_share": "top_player_ability_share",
            "top_3_share": "top_3_ability_share",
        }
    )
    stats = (
        totals.merge(ability_concentration, on="kit_id", how="left")
        .sort_values("kit_id")
        .reset_index(drop=True)
    )
    stats["players_using_ability"] = pd.to_numeric(
        stats["players_using_ability"], errors="coerce"
    ).fillna(0).astype(int)
    return (
        player_metrics.sort_values(["kit_id", "id"]).reset_index(drop=True),
        totals.sort_values("kit_id").reset_index(drop=True),
        stats,
    )


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
    player_elo: pd.DataFrame,
) -> pd.DataFrame:
    kills = player_kit_kills.rename(columns={"id_killer": "id"})[
        ["id", "kit_id", "kills"]
    ]
    ability_columns = [
        "id",
        "kit_id",
        "ability_use",
        "successful_uses",
        "ability_effect_value",
    ]
    abilities = player_kit_abilities[ability_columns]
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
            player_elo[["id", "rating", "rated_encounters"]],
            on="id",
            how="left",
            validate="many_to_one",
        )
        .merge(
            kit_settings[
                [
                    "kit_id",
                    "ability_cooldown",
                    "ability_cooldown_seconds",
                    "theoretical_ability_uses_per_hour",
                    "ability_path",
                    "ability_name",
                    "ability_duration",
                    "supports_success_metric",
                    "supports_effect_metric",
                    "ability_effect_metric_id",
                    "ability_effect_metric_name",
                    "ability_effect_description",
                    "ability_effect_unit",
                    "ability_effect_source_type",
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
    success_mask = metrics["supports_success_metric"].fillna(False)
    metrics.loc[success_mask, "successful_uses"] = metrics.loc[
        success_mask, "successful_uses"
    ].fillna(0)
    metrics.loc[~success_mask, "successful_uses"] = np.nan
    effect_mask = metrics["supports_effect_metric"].fillna(False)
    metrics.loc[effect_mask, "ability_effect_value"] = metrics.loc[
        effect_mask, "ability_effect_value"
    ].fillna(0.0)
    metrics.loc[~effect_mask, "ability_effect_value"] = np.nan

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
    metrics["ability_success_rate"] = _safe_divide(
        metrics["successful_uses"], metrics["ability_use"]
    )
    metrics["ability_effect_per_use"] = _safe_divide(
        metrics["ability_effect_value"], metrics["ability_use"]
    )
    metrics["ability_effect_per_successful_use"] = _safe_divide(
        metrics["ability_effect_value"], metrics["successful_uses"]
    )
    metrics["ability_effect_per_hour"] = _safe_divide(
        metrics["ability_effect_value"], metrics["total_hours"]
    )
    metrics["ability_effect_per_completed_life"] = _safe_divide(
        metrics["ability_effect_value"], metrics["completed_lives"]
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
        "ability_success_rate": "players_with_ability_success_rate",
        "ability_effect_per_use": "players_with_ability_effect_per_use",
        "ability_effect_per_successful_use": (
            "players_with_ability_effect_per_successful_use"
        ),
        "ability_effect_per_hour": "players_with_ability_effect_per_hour",
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
    kit_elo_context: pd.DataFrame,
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
            total_abilities_by_kit[
                [
                    "kit_id",
                    "ability_use",
                    "successful_uses",
                    "ability_effect_value",
                    "players_with_successful_use",
                    "players_with_effect",
                ]
            ],
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
        .merge(
            kit_elo_context.drop(columns="kit_name"),
            on="kit_id",
            how="left",
            validate="one_to_one",
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
    metrics["successful_uses_per_hour"] = _safe_divide(
        metrics["successful_uses"], metrics["total_hours"]
    )
    metrics["ability_success_rate"] = _safe_divide(
        metrics["successful_uses"], metrics["ability_use"]
    )
    metrics["ability_effect_per_use"] = _safe_divide(
        metrics["ability_effect_value"], metrics["ability_use"]
    )
    metrics["ability_effect_per_successful_use"] = _safe_divide(
        metrics["ability_effect_value"], metrics["successful_uses"]
    )
    metrics["ability_effect_per_hour"] = _safe_divide(
        metrics["ability_effect_value"], metrics["total_hours"]
    )
    metrics["ability_effect_per_completed_life"] = _safe_divide(
        metrics["ability_effect_value"], metrics["completed_lives"]
    )
    for unit, suffix in (("players", "players"), ("hearts", "hearts")):
        unit_mask = metrics["ability_effect_unit"].eq(unit)
        metrics[f"ability_effect_per_successful_use_{suffix}"] = metrics[
            "ability_effect_per_successful_use"
        ].where(unit_mask)
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
    """Compare output and exposure for kill- and playtime-selected players."""

    output_columns = [
        "kit_id",
        "kit_name",
        "top_killer_id",
        "top_killer_kills",
        "top_killer_hours",
        "top_killer_completed_lives",
        "top_killer_kills_per_hour",
        "top_killer_kills_per_completed_life",
        "top_killer_rating",
        "top_killer_rated_encounters",
        "top_killer_kill_share",
        "top_killer_time_share",
        "top_killer_kill_share_minus_time_share",
        "top_killer_kill_to_time_share_ratio",
        "top_playtime_player_id",
        "top_playtime_player_kills",
        "top_playtime_player_hours",
        "top_playtime_player_completed_lives",
        "top_playtime_player_kills_per_hour",
        "top_playtime_player_kills_per_completed_life",
        "top_playtime_player_rating",
        "top_playtime_player_rated_encounters",
        "top_playtime_player_kill_share",
        "top_playtime_player_time_share",
        "top_playtime_player_kill_share_minus_time_share",
        "top_playtime_player_kill_to_time_share_ratio",
        "same_top_killer_and_playtime_player",
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
                "rating",
                "rated_encounters",
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
                "rating": "top_killer_rating",
                "rated_encounters": "top_killer_rated_encounters",
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
    # Exact playtime ties are resolved by kill count, then ID, because tied
    # players have the same x-coordinate but may have different kill shares.
    top_playtime_players = (
        player_kit_metrics.loc[player_kit_metrics["total_time"] > 0]
        .sort_values(
            ["kit_id", "total_time", "kills", "id"],
            ascending=[True, False, False, True],
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
                "rating",
                "rated_encounters",
                "player_kill_share_of_kit",
                "player_time_share_of_kit",
                "kill_share_minus_time_share",
                "kill_to_time_share_ratio",
            ]
        ]
        .rename(
            columns={
                "id": "top_playtime_player_id",
                "kills": "top_playtime_player_kills",
                "total_hours": "top_playtime_player_hours",
                "completed_lives": (
                    "top_playtime_player_completed_lives"
                ),
                "kills_per_hour": "top_playtime_player_kills_per_hour",
                "kills_per_completed_life": (
                    "top_playtime_player_kills_per_completed_life"
                ),
                "rating": "top_playtime_player_rating",
                "rated_encounters": (
                    "top_playtime_player_rated_encounters"
                ),
                "player_kill_share_of_kit": (
                    "top_playtime_player_kill_share"
                ),
                "player_time_share_of_kit": (
                    "top_playtime_player_time_share"
                ),
                "kill_share_minus_time_share": (
                    "top_playtime_player_kill_share_minus_time_share"
                ),
                "kill_to_time_share_ratio": (
                    "top_playtime_player_kill_to_time_share_ratio"
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
    result = top_killers.merge(
        top_playtime_players,
        on=["kit_id", "kit_name"],
        how="left",
    ).merge(kit_context, on="kit_id", how="left")
    result["same_top_killer_and_playtime_player"] = (
        result["top_killer_id"] == result["top_playtime_player_id"]
    )
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

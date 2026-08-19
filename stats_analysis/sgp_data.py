"""Loading, validation, and derived datasets for the SGP kit report.

This module deliberately contains no visualization code.  It turns the three
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

KILL_COLUMNS = ("id_killer", "kit_id_killer", "kit_id_victim", "kills")
ABILITY_COLUMNS = ("id", "kit_id", "ability_use")
PICK_COLUMNS = ("id", "kit_id", "total_time", "nbr_picks")

# The default assumes ``total_time`` is logged in Minecraft game ticks.  Keep
# the conversion configurable at the public entry points in case the datapack
# increments this counter at another cadence.
DEFAULT_TIME_UNITS_PER_HOUR = 20 * 60 * 60


@dataclass(frozen=True)
class ReportData:
    """Validated extracts and reusable tables consumed by the report.

    Raw extract naming is preserved in ``picks``.  Analysis-facing tables call
    ``nbr_picks`` "completed_lives" because the counter represents completed
    full lives rather than every kit-selection event.
    """

    kills: pd.DataFrame
    abilities: pd.DataFrame
    picks: pd.DataFrame
    all_kits: pd.DataFrame
    player_kit_kills: pd.DataFrame
    total_kills_by_kit: pd.DataFrame
    kit_kill_stats: pd.DataFrame
    matchup_matrix: pd.DataFrame
    directional_share: np.ndarray
    pair_totals: np.ndarray
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
    """Load the three normalized extracts and prepare shared report tables.

    ``time_units_per_hour`` defaults to 72,000, assuming ``total_time`` is
    measured in Minecraft ticks.  Override it if the datapack records a
    different unit (for example, use 3,600 when it records seconds).
    """

    data_dir = Path(data_dir)
    kills = pd.read_parquet(data_dir / "kills.parquet")
    abilities = pd.read_parquet(data_dir / "abilities.parquet")
    picks = pd.read_parquet(data_dir / "picks.parquet")
    return prepare_report_data(
        kills,
        abilities,
        picks,
        time_units_per_hour=time_units_per_hour,
    )


def prepare_report_data(
    kills: pd.DataFrame,
    abilities: pd.DataFrame,
    picks: pd.DataFrame,
    *,
    time_units_per_hour: float = DEFAULT_TIME_UNITS_PER_HOUR,
) -> ReportData:
    """Validate normalized inputs and derive analysis-ready datasets."""

    if not np.isfinite(time_units_per_hour) or time_units_per_hour <= 0:
        raise ValueError("time_units_per_hour must be a positive finite value")

    kills, abilities, picks = _validate_and_normalize(
        kills,
        abilities,
        picks,
    )
    all_kits = pd.DataFrame(
        {
            "kit_id": list(KIT_ID_TO_NAME),
            "kit_name": list(KIT_ID_TO_NAME.values()),
        }
    )

    player_kit_kills = (
        kills.groupby(["id_killer", "kit_id_killer"], as_index=False)[
            "kills"
        ]
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

    matchup_counts = kills.groupby(
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

    all_player_ids = (
        set(kills["id_killer"]) | set(abilities["id"]) | set(picks["id"])
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
    player_kit_metrics = _build_player_kit_metrics(
        player_kit_exposure,
        player_kit_kills,
        player_kit_abilities,
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
        abilities=abilities,
        picks=picks,
        all_kits=all_kits,
        player_kit_kills=player_kit_kills,
        total_kills_by_kit=total_kills_by_kit,
        kit_kill_stats=kit_kill_stats,
        matchup_matrix=matchup_matrix,
        directional_share=directional_share,
        pair_totals=pair_totals,
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
    abilities: pd.DataFrame,
    picks: pd.DataFrame,
) -> tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    _require_columns(kills, KILL_COLUMNS, "kills")
    _require_columns(abilities, ABILITY_COLUMNS, "abilities")
    _require_columns(picks, PICK_COLUMNS, "picks")

    kills = kills.copy()
    abilities = abilities.copy()
    picks = picks.copy()
    for frame, columns, name in (
        (kills, KILL_COLUMNS, "kills"),
        (abilities, ABILITY_COLUMNS, "abilities"),
        (picks, PICK_COLUMNS, "picks"),
    ):
        if frame[list(columns)].isna().any().any():
            raise ValueError(f"{name} contains missing values")

    kills["id_killer"] = kills["id_killer"].astype(str)
    for column in ("kit_id_killer", "kit_id_victim", "kills"):
        kills[column] = pd.to_numeric(kills[column], errors="raise").astype(int)

    abilities["id"] = abilities["id"].astype(str)
    for column in ("kit_id", "ability_use"):
        abilities[column] = pd.to_numeric(
            abilities[column], errors="raise"
        ).astype(int)

    picks["id"] = picks["id"].astype(str)
    for column in ("kit_id", "total_time", "nbr_picks"):
        picks[column] = pd.to_numeric(picks[column], errors="raise").astype(int)

    if (kills["kills"] < 0).any():
        raise ValueError("Negative kill count found")
    if (abilities["ability_use"] < 0).any():
        raise ValueError("Negative ability-use count found")
    if (picks["total_time"] < 0).any():
        raise ValueError("Negative total_time found")
    if (picks["nbr_picks"] < 0).any():
        raise ValueError("Negative nbr_picks found")
    if not kills["kit_id_killer"].isin(KIT_ID_TO_NAME).all():
        raise ValueError("Unknown killer kit ID found")
    if not kills["kit_id_victim"].isin(KIT_ID_TO_NAME).all():
        raise ValueError("Unknown victim kit ID found")
    if not abilities["kit_id"].isin(KIT_ID_TO_NAME).all():
        raise ValueError("Unknown ability kit ID found")
    valid_pick_ids = set(KIT_ID_TO_NAME) | {NO_KIT_ID}
    if not picks["kit_id"].isin(valid_pick_ids).all():
        raise ValueError("Unknown pick kit ID found")
    if kills.duplicated(
        ["id_killer", "kit_id_killer", "kit_id_victim"]
    ).any():
        raise ValueError("Duplicate kill-stat rows found")
    if abilities.duplicated(["id", "kit_id"]).any():
        raise ValueError("Duplicate ability-use rows found")
    if picks.duplicated(["id", "kit_id"]).any():
        raise ValueError("Duplicate pick-stat rows found")

    return kills, abilities, picks


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
) -> pd.DataFrame:
    observed = per_player.groupby(
        ["kit_id", "kit_name"], as_index=False
    )[value_col].sum()
    complete = all_kits.merge(
        observed,
        on=["kit_id", "kit_name"],
        how="left",
    ).fillna({value_col: 0})
    complete[value_col] = complete[value_col].astype(int)
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
) -> tuple[np.ndarray, np.ndarray]:
    counts = matchup_matrix.to_numpy(dtype=int)
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


def _build_player_kit_metrics(
    player_kit_exposure: pd.DataFrame,
    player_kit_kills: pd.DataFrame,
    player_kit_abilities: pd.DataFrame,
) -> pd.DataFrame:
    kills = player_kit_kills.rename(columns={"id_killer": "id"})[
        ["id", "kit_id", "kills"]
    ]
    abilities = player_kit_abilities[["id", "kit_id", "ability_use"]]
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

    kit_kills = metrics.groupby("kit_id")["kills"].transform("sum")
    kit_abilities = metrics.groupby("kit_id")["ability_use"].transform("sum")
    metrics["player_kill_share_of_kit"] = _safe_divide(
        metrics["kills"], kit_kills
    )
    metrics["player_ability_use_share_of_kit"] = _safe_divide(
        metrics["ability_use"], kit_abilities
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
    return metrics.sort_values(["kit_id", "id"]).reset_index(drop=True)


def _build_player_rate_stats(
    player_kit_metrics: pd.DataFrame,
    all_kits: pd.DataFrame,
) -> pd.DataFrame:
    specs = {
        "kills_per_hour": "players_with_kill_rate_per_hour",
        "kills_per_completed_life": "players_with_kill_rate_per_life",
        "ability_uses_per_hour": "players_with_ability_rate_per_hour",
        "ability_uses_per_completed_life": (
            "players_with_ability_rate_per_life"
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
) -> pd.DataFrame:
    metrics = (
        all_kits.merge(
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
            player_rate_stats.drop(columns="kit_name"),
            on="kit_id",
            how="left",
        )
    )
    metrics[["kills", "ability_use"]] = metrics[
        ["kills", "ability_use"]
    ].fillna(0).astype(int)
    metrics["kill_share"] = _safe_divide(
        metrics["kills"],
        pd.Series(metrics["kills"].sum(), index=metrics.index),
    )
    metrics["ability_use_share"] = _safe_divide(
        metrics["ability_use"],
        pd.Series(metrics["ability_use"].sum(), index=metrics.index),
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
    metrics["kill_share_minus_time_share"] = (
        metrics["kill_share"] - metrics["time_share"]
    )
    metrics["kill_to_time_share_ratio"] = _safe_divide(
        metrics["kill_share"], metrics["time_share"]
    )
    metrics["ability_use_to_time_share_ratio"] = _safe_divide(
        metrics["ability_use_share"], metrics["time_share"]
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

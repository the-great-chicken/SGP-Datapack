"""Shared schemas, report model, and small numerical primitives."""

from __future__ import annotations

from dataclasses import dataclass

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

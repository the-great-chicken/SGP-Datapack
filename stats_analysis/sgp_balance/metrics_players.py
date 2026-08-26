"""Exposure and cross-domain player/kit summary derivations."""

from __future__ import annotations

import numpy as np
import pandas as pd

from .core import (
    KIT_ID_TO_NAME,
    KIT_NAMES,
    KIT_ORDER,
    NO_KIT_ID,
    _concentration_from_counts,
    _safe_divide,
)


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


def _ranked_contribution_profile(
    frame: pd.DataFrame,
    *,
    metric_id: str,
    player_col: str,
    value_col: str,
) -> pd.DataFrame:
    """Rank positive contributors and retain their full kit-total shares."""

    columns = (
        "metric_id",
        "kit_id",
        "kit_name",
        "player_id",
        "value",
        "share",
        "rank",
        "contributors",
        "rank_fraction",
        "cumulative_share",
        "top_three_share",
    )
    profile = frame[
        [player_col, "kit_id", "kit_name", value_col]
    ].rename(
        columns={
            player_col: "player_id",
            value_col: "value",
        }
    )
    profile["value"] = pd.to_numeric(
        profile["value"], errors="coerce"
    ).replace([np.inf, -np.inf], np.nan)
    profile = profile.loc[
        profile["kit_name"].notna() & (profile["value"] > 0)
    ].copy()
    if profile.empty:
        return pd.DataFrame(columns=columns)

    profile["player_id"] = profile["player_id"].astype(str)
    profile = profile.groupby(
        ["kit_id", "kit_name", "player_id"],
        as_index=False,
        sort=False,
    )["value"].sum()
    profile = profile.sort_values(
        ["kit_id", "value", "player_id"],
        ascending=[True, False, True],
        kind="stable",
    ).reset_index(drop=True)
    groups = profile.groupby("kit_id", sort=False)
    profile["rank"] = groups.cumcount() + 1
    profile["contributors"] = groups["player_id"].transform("size")
    totals = groups["value"].transform("sum")
    profile["share"] = profile["value"] / totals
    profile["cumulative_share"] = profile.groupby(
        "kit_id", sort=False
    )["share"].cumsum()
    top_three = (
        profile.loc[profile["rank"] <= 3]
        .groupby("kit_id", sort=False)["share"]
        .sum()
    )
    profile["top_three_share"] = profile["kit_id"].map(top_three)
    rank_denominator = (profile["contributors"] - 1).replace(0, np.nan)
    profile["rank_fraction"] = (
        (profile["rank"] - 1) / rank_denominator
    ).fillna(0.0)
    profile["metric_id"] = metric_id
    return profile[list(columns)]


def _build_player_concentration_profiles(
    player_kit_kills: pd.DataFrame,
    player_kit_damage_dealt: pd.DataFrame,
    player_kit_damage_received: pd.DataFrame,
    player_kit_exposure: pd.DataFrame,
) -> pd.DataFrame:
    """Build comparable ranked profiles for output and exposure modes."""

    profiles = (
        _ranked_contribution_profile(
            player_kit_kills,
            metric_id="kills",
            player_col="id_killer",
            value_col="kills",
        ),
        _ranked_contribution_profile(
            player_kit_damage_dealt,
            metric_id="damage_dealt",
            player_col="id_source",
            value_col="damage_dealt",
        ),
        _ranked_contribution_profile(
            player_kit_damage_received,
            metric_id="damage_received",
            player_col="id_target",
            value_col="damage_received",
        ),
        _ranked_contribution_profile(
            player_kit_exposure,
            metric_id="playtime",
            player_col="id",
            value_col="total_hours",
        ),
        _ranked_contribution_profile(
            player_kit_exposure,
            metric_id="completed_lives",
            player_col="id",
            value_col="completed_lives",
        ),
    )
    return pd.concat(profiles, ignore_index=True)


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
                    "ability_success_metric_name",
                    "ability_success_description",
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

"""Combat, damage, matchup, and Elo-context derivations."""

from __future__ import annotations

import numpy as np
import pandas as pd

from .core import (
    DAMAGE_CAUSE_COLUMNS,
    KIT_ID_TO_NAME,
    KIT_NAMES,
    NO_PLAYER_ID,
    _complete_metric_totals,
    _concentration_from_counts,
    _directional_tables,
    _safe_divide,
)


def _build_kill_tables(
    attributed_kills: pd.DataFrame,
    all_kits: pd.DataFrame,
) -> tuple[
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    np.ndarray,
    np.ndarray,
]:
    """Build kit totals, concentration, and pairwise kill tables."""

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
        total_kills_by_kit.merge(
            kill_concentration,
            on="kit_id",
            how="left",
        )
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
    return (
        player_kit_kills,
        total_kills_by_kit,
        kit_kill_stats,
        matchup_matrix,
        directional_share,
        pair_totals,
    )


def _build_damage_tables(
    damage_received: pd.DataFrame,
    attributed_damage: pd.DataFrame,
    all_kits: pd.DataFrame,
) -> tuple[
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    np.ndarray,
    np.ndarray,
]:
    """Build offensive, defensive, and pairwise damage tables."""

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

    damage_matchup_counts = attributed_damage.groupby(
        ["kit_id_source", "kit_id_target"], as_index=False
    )["damage_received"].sum()
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
    return (
        player_kit_damage_dealt,
        total_damage_dealt_by_kit,
        kit_damage_dealt_stats,
        player_kit_damage_received,
        kit_damage_received_stats,
        damage_matchup_matrix,
        damage_directional_share,
        damage_pair_totals,
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

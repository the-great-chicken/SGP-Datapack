"""Ability metadata, activity, success, and effect derivations."""

from __future__ import annotations

import numpy as np
import pandas as pd

from .core import (
    KIT_ID_TO_NAME,
    _concentration_from_counts,
    _safe_divide,
)


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
    success_metadata = ability_metadata.loc[
        ability_metadata["metric_id"].eq("successful_uses"),
        ["kit_id", "metric_name", "description"],
    ].rename(
        columns={
            "metric_name": "ability_success_metric_name",
            "description": "ability_success_description",
        }
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
            success_metadata,
            on="kit_id",
            how="left",
            validate="one_to_one",
        )
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
        "ability_success_metric_name",
        "ability_success_description",
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

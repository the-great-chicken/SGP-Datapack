"""Ability activity, effectiveness, and outcome-comparison figures."""

from __future__ import annotations

import numpy as np
import pandas as pd
import plotly.graph_objects as go

from .core import ReportData
from .plot_components import (
    AggregateMetricView,
    QuadrantMode,
    _ability_effect_per_success_text,
    _format_hours,
    _quadrant_modes_figure,
    player_contribution_figure,
)


def ability_uses_figure(report: ReportData) -> go.Figure:
    """Build activation, player-contribution, and success-rate modes."""

    totals = report.kit_metrics.copy()
    totals["ability_effect_per_success_text"] = (
        _ability_effect_per_success_text(totals)
    )
    totals["active_time_text"] = totals["total_hours"].map(_format_hours)
    return player_contribution_figure(
        all_kits=report.all_kits,
        totals=totals,
        by_player=report.player_kit_abilities,
        player_col="id",
        player_value_col="ability_use",
        median_per_hour_col="median_player_ability_uses_per_hour",
        median_per_life_col=(
            "median_player_ability_uses_per_completed_life"
        ),
        player_title=(
            "Which players account for each kit's ability activations?"
        ),
        aggregate_customdata_cols=(
            "ability_cooldown_seconds",
            "theoretical_ability_uses_per_hour",
            "ability_uses_per_hour",
            "cooldown_normalized_use_rate",
            "median_player_cooldown_normalized_use_rate",
            "successful_uses",
            "ability_success_rate",
            "median_player_ability_success_rate",
            "ability_effect_value",
            "ability_effect_metric_name",
            "ability_effect_per_successful_use",
            "ability_effect_unit",
            "ability_effect_description",
            "ability_name",
            "ability_effect_per_success_text",
            "ability_success_description",
            "active_time_text",
            "players_with_cooldown_normalized_use_rate",
            "players_with_ability_success_rate",
            "players_with_ability_rate_per_life",
        ),
        metric_views=(
            AggregateMetricView(
                button_label="Total uses",
                value_col="ability_use",
                title="Which abilities were activated most often?",
                yaxis_title="Ability uses",
                tickformat=",.0f",
                hovertemplate=(
                    "<b>%{x} — %{customdata[19]}</b><br>"
                    "Ability uses: %{y:,.0f}<br>"
                    "Active time: %{customdata[22]}<br>"
                    "Cooldown: %{customdata[6]:.1f} s"
                    "<extra></extra>"
                ),
            ),
            AggregateMetricView(
                button_label="Cooldown-normalized",
                value_col="cooldown_normalized_use_rate",
                title=(
                    "Which abilities were activated most often relative "
                    "to their cooldown?"
                ),
                yaxis_title="Share of cooldown-only maximum use rate",
                tickformat=".1%",
                hovertemplate=(
                    "<b>%{x} — %{customdata[19]}</b><br>"
                    "Kit aggregate normalized rate: "
                    "%{y:.1%}<br>Median individual player rate: "
                    "%{customdata[10]:.1%} "
                    "(players: %{customdata[23]:,.0f})<br>"
                    "Observed uses per hour: "
                    "%{customdata[8]:.2f}<br>Cooldown-only maximum: "
                    "%{customdata[7]:.2f} uses / h<br>Cooldown: "
                    "%{customdata[6]:.1f} s<br>Total uses: "
                    "%{customdata[0]:,.0f}<br>Active time: "
                    "%{customdata[22]}"
                    "<extra></extra>"
                ),
            ),
            AggregateMetricView(
                button_label="Success rate",
                value_col="ability_success_rate",
                title=(
                    "Which abilities met their logged success condition "
                    "most consistently?"
                ),
                yaxis_title="Share of uses meeting the ability's success condition",
                tickformat=".1%",
                yaxis_range=(0, 1.05),
                hovertemplate=(
                    "<b>%{x} — %{customdata[19]}</b><br>Success rate: "
                    "%{y:.1%}<br>Median individual player rate: "
                    "%{customdata[13]:.1%} "
                    "(players: %{customdata[24]:,.0f})<br>"
                    "Successful uses: "
                    "%{customdata[11]:,.0f} / %{customdata[0]:,.0f}<br>"
                    "Success condition: %{customdata[21]}<br>"
                    "Logged effect: %{customdata[20]}"
                    "<extra></extra>"
                ),
            ),
            AggregateMetricView(
                button_label="Uses / life",
                value_col="ability_uses_per_completed_life",
                title=(
                    "Which abilities were activated most often per "
                    "completed life?"
                ),
                yaxis_title="Ability uses per completed life",
                tickformat=".2f",
                hovertemplate=(
                    "<b>%{x} — %{customdata[19]}</b><br>"
                    "Kit aggregate rate: %{y:.2f} uses / completed life<br>"
                    "Median individual player rate: "
                    "%{customdata[5]:.2f} uses / completed life "
                    "(players: %{customdata[25]:,.0f})<br>"
                    "Total uses: "
                    "%{customdata[0]:,.0f}<br>"
                    "Completed lives: %{customdata[2]:,.0f}"
                    "<extra></extra>"
                ),
            ),
        ),
    )


def ability_effectiveness_figure(report: ReportData) -> go.Figure:
    """Compare ability engagement with success and comparable effect sizes."""

    plot_data = report.kit_metrics.copy()
    plot_data["ability_effect_per_success_text"] = (
        _ability_effect_per_success_text(plot_data)
    )
    return _quadrant_modes_figure(
        plot_data,
        customdata_cols=(
            "ability_use",
            "successful_uses",
            "ability_success_rate",
            "cooldown_normalized_use_rate",
            "ability_uses_per_hour",
            "ability_effect_value",
            "ability_effect_per_successful_use",
            "ability_effect_unit",
            "ability_effect_metric_name",
            "ability_effect_description",
            "total_hours",
            "ability_name",
            "players_with_ability_success_rate",
            "median_player_ability_success_rate",
            "players_with_ability_effect_per_successful_use",
            "median_player_ability_effect_per_successful_use",
            "ability_effect_per_success_text",
            "ability_success_description",
        ),
        modes=(
            QuadrantMode(
                button_label="Success rate",
                x_col="cooldown_normalized_use_rate",
                y_col="ability_success_rate",
                title=(
                    "Which abilities combine high cooldown-adjusted use "
                    "with high success rates?"
                ),
                xaxis_title="Cooldown-normalized activation rate",
                yaxis_title="Successful uses / uses",
                x_tickformat=".0%",
                y_tickformat=".0%",
                quadrant_labels=(
                    "Lower engagement<br>higher success",
                    "Higher engagement<br>higher success",
                    "Lower engagement<br>lower success",
                    "Higher engagement<br>lower success",
                ),
                hovertemplate=(
                    "<b>%{fullData.name} — %{customdata[11]}</b><br>"
                    "Cooldown-normalized activation: %{x:.1%}<br>"
                    "Successful-use rate: %{y:.1%}<br>Successful uses: "
                    "%{customdata[1]:,.0f} / %{customdata[0]:,.0f}<br>"
                    "Median individual player rate: %{customdata[13]:.1%} "
                    "(%{customdata[12]:,.0f} players)<br>"
                    "Success condition: %{customdata[17]}"
                    "<extra></extra>"
                ),
            ),
            QuadrantMode(
                button_label="Players / success",
                x_col="cooldown_normalized_use_rate",
                y_col="ability_effect_per_successful_use_players",
                title=(
                    "How does cooldown-adjusted ability use relate to "
                    "players affected per successful cast?"
                ),
                xaxis_title="Cooldown-normalized activation rate",
                yaxis_title="Players affected per successful use",
                x_tickformat=".0%",
                y_tickformat=".2f",
                quadrant_labels=(
                    "Lower engagement<br>broader successful casts",
                    "Higher engagement<br>broader successful casts",
                    "Lower engagement<br>narrower successful casts",
                    "Higher engagement<br>narrower successful casts",
                ),
                hovertemplate=(
                    "<b>%{fullData.name} — %{customdata[11]}</b><br>"
                    "Cooldown-normalized activation: %{x:.1%}<br>"
                    "Players affected per successful use: %{y:.2f}<br>"
                    "Successful-use rate: %{customdata[2]:.1%}<br>"
                    "Successful uses: %{customdata[1]:,.0f} / "
                    "%{customdata[0]:,.0f}<br>Total players affected: "
                    "%{customdata[5]:,.0f}<br>Median individual result: "
                    "%{customdata[15]:.2f} players / success "
                    "(%{customdata[14]:,.0f} players)<br>"
                    "Effect measured: %{customdata[9]}"
                    "<extra></extra>"
                ),
            ),
            QuadrantMode(
                button_label="Hearts / success",
                x_col="cooldown_normalized_use_rate",
                y_col="ability_effect_per_successful_use_hearts",
                title=(
                    "How does cooldown-adjusted ability use relate to "
                    "health impact per successful use?"
                ),
                xaxis_title="Cooldown-normalized activation rate",
                yaxis_title="Health impact per successful use (hearts)",
                x_tickformat=".0%",
                y_tickformat=".2f",
                quadrant_labels=(
                    "Lower engagement<br>larger health impact",
                    "Higher engagement<br>larger health impact",
                    "Lower engagement<br>smaller health impact",
                    "Higher engagement<br>smaller health impact",
                ),
                hovertemplate=(
                    "<b>%{fullData.name} — %{customdata[11]}</b><br>"
                    "Cooldown-normalized activation: %{x:.1%}<br>"
                    "%{customdata[8]} per successful use: %{y:,.0f} hearts<br>"
                    "Successful-use rate: %{customdata[2]:.1%}<br>"
                    "Successful uses: %{customdata[1]:,.0f} / "
                    "%{customdata[0]:,.0f}<br>Total health impact: "
                    "%{customdata[5]:,.0f} hearts<br>Median individual result: "
                    "%{customdata[15]:,.0f} hearts / success "
                    "(%{customdata[14]:,.0f} players)<br>"
                    "Effect measured: %{customdata[9]}"
                    "<extra></extra>"
                ),
            ),
        ),
    )


def kills_vs_ability_uses_figure(combined_totals: pd.DataFrame) -> go.Figure:
    """Compare kills with ability volume and cooldown-adjusted use."""

    plot_data = combined_totals.copy()
    plot_data["ability_effect_per_success_text"] = (
        _ability_effect_per_success_text(plot_data)
    )
    plot_data["active_time_text"] = plot_data["total_hours"].map(
        _format_hours
    )
    return _quadrant_modes_figure(
        plot_data,
        customdata_cols=(
            "ability_use",
            "kills",
            "active_time_text",
            "completed_lives",
            "ability_cooldown_seconds",
            "ability_uses_per_hour",
            "cooldown_normalized_use_rate",
            "successful_uses",
            "ability_success_rate",
            "ability_effect_metric_name",
            "ability_effect_per_successful_use",
            "ability_effect_unit",
            "ability_effect_per_success_text",
        ),
        modes=(
            QuadrantMode(
                button_label="Totals",
                x_col="ability_use",
                y_col="kills",
                title=(
                    "Are kits with more ability activations also recording "
                    "more kills?"
                ),
                xaxis_title="Ability uses",
                yaxis_title="Kills",
                x_tickformat=",.0f",
                y_tickformat=",.0f",
                quadrant_labels=(
                    "Low ability use<br>high kills",
                    "High ability use<br>high kills",
                    "Low ability use<br>low kills",
                    "High ability use<br>low kills",
                ),
                hovertemplate=(
                    "<b>%{fullData.name}</b><br>Ability uses: %{x:,.0f}<br>"
                    "Kills: %{y:,.0f}<br>Active time: "
                    "%{customdata[2]}<br>Cooldown: "
                    "%{customdata[4]:.1f} s<extra></extra>"
                ),
            ),
            QuadrantMode(
                button_label="Cooldown-normalized",
                x_col="cooldown_normalized_use_rate",
                y_col="kills_per_hour",
                title=(
                    "Is cooldown-adjusted ability engagement associated "
                    "with kill rate?"
                ),
                xaxis_title="Cooldown-normalized ability-use rate",
                yaxis_title="Kills per hour",
                x_tickformat=".0%",
                y_tickformat=".2f",
                quadrant_labels=(
                    "Low normalized use<br>high kill rate",
                    "High normalized use<br>high kill rate",
                    "Low normalized use<br>low kill rate",
                    "High normalized use<br>low kill rate",
                ),
                hovertemplate=(
                    "<b>%{fullData.name}</b><br>Cooldown-normalized rate: "
                    "%{x:.1%}<br>Kills per hour: %{y:.2f}<br>"
                    "Observed ability uses per hour: "
                    "%{customdata[5]:.2f}<br>Cooldown: "
                    "%{customdata[4]:.1f} s<br>Total uses: "
                    "%{customdata[0]:,.0f}<br>Total kills: "
                    "%{customdata[1]:,.0f}<br>Active time: "
                    "%{customdata[2]}<extra></extra>"
                ),
            ),
            QuadrantMode(
                button_label="Success rate",
                x_col="ability_success_rate",
                y_col="kills_per_hour",
                title="Is ability success rate associated with kill rate?",
                xaxis_title="Successful uses / uses",
                yaxis_title="Kills per hour",
                x_tickformat=".0%",
                y_tickformat=".2f",
                quadrant_labels=(
                    "Lower success<br>higher kill rate",
                    "Higher success<br>higher kill rate",
                    "Lower success<br>lower kill rate",
                    "Higher success<br>lower kill rate",
                ),
                hovertemplate=(
                    "<b>%{fullData.name}</b><br>Successful-use rate: "
                    "%{x:.1%}<br>Kills per hour: %{y:.2f}<br>"
                    "Successful uses: %{customdata[7]:,.0f} / "
                    "%{customdata[0]:,.0f}<br>Cooldown-normalized "
                    "activation: %{customdata[6]:.1%}"
                    "<extra></extra>"
                ),
            ),
            QuadrantMode(
                button_label="Per life",
                x_col="ability_uses_per_completed_life",
                y_col="kills_per_completed_life",
                title=(
                    "Are more ability activations per life associated with "
                    "more kills per life?"
                ),
                xaxis_title="Ability uses per completed life",
                yaxis_title="Kills per completed life",
                x_tickformat=".2f",
                y_tickformat=".2f",
                quadrant_labels=(
                    "Low uses per life<br>high kills per life",
                    "High uses per life<br>high kills per life",
                    "Low uses per life<br>low kills per life",
                    "High uses per life<br>low kills per life",
                ),
                hovertemplate=(
                    "<b>%{fullData.name}</b><br>Ability uses per life: "
                    "%{x:.2f}<br>Kills per life: %{y:.2f}<br>"
                    "Total uses: %{customdata[0]:,.0f}<br>Total kills: "
                    "%{customdata[1]:,.0f}<br>Completed lives: "
                    "%{customdata[3]:,.0f}<extra></extra>"
                ),
            ),
        ),
    )

"""Reusable Plotly visualizations for the SGP kit report.

Loading, validation, and metric derivation live in :mod:`sgp_data`.  This
module is intentionally limited to visual presentation and repeated notebook
display interactions.
"""

from __future__ import annotations

import numpy as np
import pandas as pd
import plotly.graph_objects as go
from plotly.subplots import make_subplots

from sgp_data import (
    KIT_NAMES,
    KIT_ORDER,
    ReportData,
    load_report_data,
    prepare_report_data,
)
from sgp_plot_components import (
    AggregateMetricView,
    ConcentrationView,
    HorizontalReferenceLine,
    KIT_COLORS,
    QuadrantMode,
    _padded_axis_range,
    _quadrant_modes_figure,
    _quadrant_scatter_figure,
    concentration_figure,
    player_contribution_figure,
    relative_metric_heatmap,
    show_cause_profile_figure,
    show_player_contribution_figure,
)


CAUSE_COLOR_SEQUENCE = (
    "#4E79A7",
    "#F28E2B",
    "#E15759",
    "#76B7B2",
    "#59A14F",
    "#EDC948",
    "#B07AA1",
    "#FF9DA7",
    "#9C755F",
    "#BAB0AC",
)


def _elo_name(report: ReportData) -> str:
    """Return the authoritative display name for the Elo snapshot."""

    if report.elo_metadata.empty:
        return "Kill Elo"
    return str(report.elo_metadata["elo_name"].iloc[0])


def _cause_color_map(report: ReportData) -> dict[int, str]:
    """Keep shared damage-cause colors stable across cause figures."""

    cause_ids = sorted(
        set(report.kill_causes["cause_id"])
        | set(report.damage_causes["cause_id"])
    )
    return {
        cause_id: CAUSE_COLOR_SEQUENCE[
            index % len(CAUSE_COLOR_SEQUENCE)
        ]
        for index, cause_id in enumerate(cause_ids)
    }


def _ability_effect_per_success_text(data: pd.DataFrame) -> pd.Series:
    """Format heterogeneous ability effects without exposing NaN in hover."""

    values: list[str] = []
    for row in data.itertuples(index=False):
        metric_name = getattr(row, "ability_effect_metric_name")
        successful_uses = getattr(row, "successful_uses")
        effect_value = getattr(row, "ability_effect_per_successful_use")
        effect_unit = getattr(row, "ability_effect_unit")
        if pd.isna(metric_name):
            values.append("Not logged")
        elif pd.isna(successful_uses) or successful_uses <= 0:
            values.append(f"{metric_name}: no successful uses")
        elif pd.isna(effect_value):
            values.append(f"{metric_name}: unavailable")
        else:
            values.append(
                f"{metric_name}: {effect_value:,.2f} "
                f"{effect_unit} / successful use"
            )
    return pd.Series(values, index=data.index, dtype=object)


def _stacked_cause_modes_figure(
    *,
    causes: pd.DataFrame,
    modes: tuple[dict[str, object], ...],
    cause_colors: dict[int, str],
    legend_title: str,
) -> go.Figure:
    """Render switchable stacked cause profiles in one single-axis figure."""

    cause_rows = list(causes.sort_values("cause_id").itertuples(index=False))
    fig = go.Figure()
    traces_per_mode = len(cause_rows)
    for mode_index, mode in enumerate(modes):
        frame = mode["data"]
        order = mode["order"]
        for cause in cause_rows:
            cause_data = (
                frame.loc[frame["cause_id"] == cause.cause_id]
                .set_index("kit_name")
                .reindex(order)
            )
            fig.add_trace(
                go.Bar(
                    x=order,
                    y=cause_data[mode["value_col"]],
                    name=cause.cause_name,
                    legendgroup=cause.cause_name,
                    legendrank=cause.cause_id,
                    meta={
                        "role": "cause",
                        "causeId": str(cause.cause_id),
                        "highlightGroup": "cause",
                        "highlightValue": str(cause.cause_id),
                    },
                    marker=dict(
                        color=cause_colors[cause.cause_id],
                        line=dict(
                            color="rgba(255,255,255,0.75)",
                            width=0.5,
                        ),
                    ),
                    customdata=cause_data[mode["custom_cols"]].to_numpy(),
                    hovertemplate=mode["hovertemplate"],
                    visible=mode_index == 0,
                    showlegend=True,
                )
            )

    def visibility(mode_index: int) -> list[bool]:
        return [
            trace_index // traces_per_mode == mode_index
            for trace_index in range(len(fig.data))
        ]

    first_mode = modes[0]
    fig.update_layout(
        title=first_mode["title"],
        barmode="stack",
        clickmode="event",
        hovermode="closest",
        legend_title_text=legend_title,
        margin=dict(l=70, r=40, t=125, b=70),
        updatemenus=[
            {
                "type": "buttons",
                "direction": "right",
                "x": 0.5,
                "xanchor": "center",
                "y": 1.18,
                "yanchor": "top",
                "showactive": True,
                "buttons": [
                    {
                        "label": mode["button_label"],
                        "method": "update",
                        "args": [
                            {"visible": visibility(mode_index)},
                            {
                                "title": {"text": mode["title"]},
                                "xaxis": {
                                    "title": {
                                        "text": mode["xaxis_title"]
                                    },
                                    "categoryorder": "array",
                                    "categoryarray": mode["order"],
                                },
                                "yaxis": {
                                    "title": {
                                        "text": mode["yaxis_title"]
                                    },
                                    "tickformat": mode["tickformat"],
                                    "range": mode["range"],
                                    "autorange": mode["range"] is None,
                                    "rangemode": "tozero",
                                },
                            },
                        ],
                    }
                    for mode_index, mode in enumerate(modes)
                ],
            }
        ],
    )
    fig.update_xaxes(
        title=first_mode["xaxis_title"],
        categoryorder="array",
        categoryarray=first_mode["order"],
    )
    fig.update_yaxes(
        title=first_mode["yaxis_title"],
        tickformat=first_mode["tickformat"],
        range=first_mode["range"],
        rangemode="tozero",
    )
    return fig


def total_kills_figure(report: ReportData) -> go.Figure:
    """Build total, exposure-normalized, and PvP-exchange modes."""

    elo_available = not report.elo_metadata.empty
    elo_name = _elo_name(report)
    player_kills = report.player_kit_metrics.loc[
        report.player_kit_metrics["kills"] > 0,
        ["id", "kit_id", "kills", "rating", "rated_encounters"],
    ]
    life_rates = report.kit_metrics["kills_per_completed_life"].dropna()
    life_references = [
        HorizontalReferenceLine(
            value=1.0,
            label="1.0 player kill per life",
            color="#111111",
            width=4,
        )
    ]
    if not life_rates.empty:
        life_median = float(life_rates.median())
        life_references.append(
            HorizontalReferenceLine(
                value=life_median,
                label=f"Kit median: {life_median:.2f}",
                color="#6B7280",
                width=2,
                dash="dash",
            )
        )
    life_axis_max = max(
        1.0,
        float(life_rates.max()) if not life_rates.empty else 0.0,
    ) * 1.12
    pvp_death_rates = report.kit_metrics[
        "kills_per_player_caused_death"
    ].dropna()
    pvp_death_axis_max = max(
        1.0,
        float(pvp_death_rates.max()) if not pvp_death_rates.empty else 0.0,
    ) * 1.12

    return player_contribution_figure(
        all_kits=report.all_kits,
        totals=report.kit_metrics,
        by_player=player_kills,
        player_col="id",
        player_value_col="kills",
        median_per_hour_col="median_player_kills_per_hour",
        median_per_life_col="median_player_kills_per_completed_life",
        player_title="Which players account for each kit's attributed kills?",
        player_customdata_cols=("rating", "rated_encounters")
        if elo_available
        else (),
        player_hovertemplate=(
            "<b>%{x}</b><br>Player ID: %{customdata[0]}<br>"
            f"Kills: %{{y:,.0f}}<br>{elo_name}: "
            "%{customdata[1]:,.2f}<br>"
            "Rated encounters: %{customdata[2]:,.0f}<extra></extra>"
            if elo_available
            else None
        ),
        aggregate_customdata_cols=(
            "deaths",
            "deaths_per_hour",
            "player_caused_deaths",
            "non_player_deaths",
            "non_player_death_share",
            "kill_death_ratio",
        ),
        metric_views=(
            AggregateMetricView(
                button_label="Total kills",
                value_col="kills",
                title="Which kits recorded the most attributed player kills?",
                yaxis_title="Kills",
                tickformat=",.0f",
                hovertemplate=(
                    "<b>%{x}</b><br>Total kills: %{y:,.0f}<br>"
                    "Time played: %{customdata[1]:,.2f} h<br>"
                    "Completed lives: %{customdata[2]:,.0f}<br>"
                    "Players with playtime: %{customdata[3]:,.0f}<br>"
                    "Deaths while using kit: %{customdata[6]:,.0f}"
                    "<extra></extra>"
                ),
            ),
            AggregateMetricView(
                button_label="Kills / hour",
                value_col="kills_per_hour",
                title="Which kits recorded the highest kill rate per active hour?",
                yaxis_title="Kills per hour",
                tickformat=".2f",
                hovertemplate=(
                    "<b>%{x}</b><br>Kills per hour: %{y:.2f}<br>"
                    "Median player rate: %{customdata[4]:.2f}<br>"
                    "Total kills: %{customdata[0]:,.0f}<br>"
                    "Time played: %{customdata[1]:,.2f} h"
                    "<extra></extra>"
                ),
            ),
            AggregateMetricView(
                button_label="Kills / life",
                value_col="kills_per_completed_life",
                title="Which kits recorded the most kills per completed life?",
                yaxis_title="Kills per completed life",
                tickformat=".2f",
                reference_lines=tuple(life_references),
                yaxis_range=(0, life_axis_max),
                hovertemplate=(
                    "<b>%{x}</b><br>Kills per completed life: %{y:.2f}<br>"
                    "Median player rate: %{customdata[5]:.2f}<br>"
                    "Total kills: %{customdata[0]:,.0f}<br>"
                    "Completed lives: %{customdata[2]:,.0f}"
                    "<extra></extra>"
                ),
            ),
            AggregateMetricView(
                button_label="Kills / PvP death",
                value_col="kills_per_player_caused_death",
                title=(
                    "Which kits recorded the most kills per "
                    "player-caused death?"
                ),
                yaxis_title="Kills per player-caused death",
                tickformat=".2f",
                reference_lines=(
                    HorizontalReferenceLine(
                        value=1.0,
                        label="1.0 kill per player-caused death",
                        color="#111111",
                        width=4,
                    ),
                ),
                yaxis_range=(0, pvp_death_axis_max),
                hovertemplate=(
                    "<b>%{x}</b><br>Kills per player-caused death: "
                    "%{y:.2f}<br>"
                    "Kills made: %{customdata[0]:,.0f}<br>"
                    "Player-caused deaths: %{customdata[8]:,.0f}<br>"
                    "All deaths: %{customdata[6]:,.0f}<br>"
                    "Non-player deaths: %{customdata[9]:,.0f} "
                    "(%{customdata[10]:.1%})"
                    "<extra></extra>"
                ),
            ),
        ),
    )


def damage_figure(report: ReportData) -> go.Figure:
    """Compare damage output, intake, exchange, and source players."""

    elo_available = not report.elo_metadata.empty
    elo_name = _elo_name(report)
    player_damage = report.player_kit_metrics.loc[
        report.player_kit_metrics["damage_dealt"] > 0,
        [
            "id",
            "kit_id",
            "damage_dealt",
            "rating",
            "rated_encounters",
        ],
    ]
    exchange_rates = report.kit_metrics["damage_exchange_ratio"].dropna()
    exchange_axis_max = max(
        1.0,
        float(exchange_rates.max()) if not exchange_rates.empty else 0.0,
    ) * 1.12

    return player_contribution_figure(
        all_kits=report.all_kits,
        totals=report.summary,
        by_player=player_damage,
        player_col="id",
        player_value_col="damage_dealt",
        median_per_hour_col="median_player_damage_dealt_per_hour",
        median_per_life_col=(
            "median_player_damage_dealt_per_completed_life"
        ),
        player_title=(
            "Which players account for each kit's attributed damage?"
        ),
        player_customdata_cols=("rating", "rated_encounters")
        if elo_available
        else (),
        player_hovertemplate=(
            "<b>%{x}</b><br>Player ID: %{customdata[0]}<br>"
            "Damage dealt: %{y:,.1f} hearts<br>"
            f"{elo_name}: %{{customdata[1]:,.2f}}<br>"
            "Rated encounters: %{customdata[2]:,.0f}<extra></extra>"
            if elo_available
            else None
        ),
        aggregate_customdata_cols=(
            "damage_received",
            "player_damage_received",
            "non_player_damage_received",
            "damage_received_per_hour",
            "player_damage_received_per_hour",
            "non_player_damage_received_per_hour",
            "non_player_damage_received_share",
            "damage_dealt_per_kill",
            "kills",
            "players_receiving_damage",
            "top_player_received_damage_share",
            "top_3_received_damage_share",
        ),
        player_value_format=",.1f",
        metric_views=(
            AggregateMetricView(
                button_label="Total dealt",
                value_col="damage_dealt",
                title="Which kits dealt the most attributed player damage?",
                yaxis_title="Damage dealt (hearts)",
                tickformat=",.0f",
                hovertemplate=(
                    "<b>%{x}</b><br>Damage dealt: %{y:,.1f} hearts<br>"
                    "Damage received: %{customdata[6]:,.1f} hearts<br>"
                    "Player damage received: %{customdata[7]:,.1f} hearts<br>"
                    "Time played: %{customdata[1]:,.2f} h<br>"
                    "Completed lives: %{customdata[2]:,.0f}<br>"
                    "Players with playtime: %{customdata[3]:,.0f}<br>"
                    "Attributed kills: %{customdata[14]:,.0f}<br>"
                    "Damage dealt per kill: %{customdata[13]:,.1f} hearts"
                    "<extra></extra>"
                ),
            ),
            AggregateMetricView(
                button_label="Dealt / hour",
                value_col="damage_dealt_per_hour",
                title=(
                    "Which kits dealt the most attributed player damage "
                    "per active hour?"
                ),
                yaxis_title="Damage dealt per hour (hearts)",
                tickformat=",.1f",
                hovertemplate=(
                    "<b>%{x}</b><br>Damage dealt per hour: %{y:,.1f} hearts<br>"
                    "Median player rate: %{customdata[4]:,.1f} hearts / h<br>"
                    "Damage received per hour: %{customdata[9]:,.1f} hearts<br>"
                    "Total damage dealt: %{customdata[0]:,.1f} hearts<br>"
                    "Time played: %{customdata[1]:,.2f} h<br>"
                    "Attributed kills: %{customdata[14]:,.0f}"
                    "<extra></extra>"
                ),
            ),
            AggregateMetricView(
                button_label="Received / hour",
                value_col="damage_received_per_hour",
                title="Which kits received the most damage per active hour?",
                yaxis_title="Damage received per hour (hearts)",
                tickformat=",.1f",
                hovertemplate=(
                    "<b>%{x}</b><br>All damage received per hour: "
                    "%{y:,.1f} hearts<br>Player damage received per hour: "
                    "%{customdata[10]:,.1f} hearts<br>Non-player damage per hour: "
                    "%{customdata[11]:,.1f} hearts<br>Non-player damage share: "
                    "%{customdata[12]:.1%}<br>Total damage received: "
                    "%{customdata[6]:,.1f} hearts<br>Time played: "
                    "%{customdata[1]:,.2f} h<br>Targets taking damage: "
                    "%{customdata[15]:,.0f}<br>Top target's share: "
                    "%{customdata[16]:.1%}<br>Top 3 targets' share: "
                    "%{customdata[17]:.1%}<extra></extra>"
                ),
            ),
            AggregateMetricView(
                button_label="PvP exchange",
                value_col="damage_exchange_ratio",
                title=(
                    "Which kits dealt more player damage than they received?"
                ),
                yaxis_title="Damage exchange ratio",
                tickformat=".2f",
                reference_lines=(
                    HorizontalReferenceLine(
                        value=1.0,
                        label="1.0 dealt per received",
                        color="#111111",
                        width=4,
                    ),
                ),
                yaxis_range=(0, exchange_axis_max),
                hovertemplate=(
                    "<b>%{x}</b><br>Damage exchange ratio: %{y:.2f}<br>"
                    "Player damage dealt: %{customdata[0]:,.1f} hearts<br>"
                    "Player damage received: %{customdata[7]:,.1f} hearts<br>"
                    "All damage received: %{customdata[6]:,.1f} hearts<br>"
                    "Non-player damage: %{customdata[8]:,.1f} hearts "
                    "(%{customdata[12]:.1%})<br>Attributed kills: "
                    "%{customdata[14]:,.0f}<extra></extra>"
                ),
            ),
        ),
    )


def kill_causes_figure(report: ReportData) -> go.Figure:
    """Compare offensive kill identity with defensive cause vulnerability."""

    causes = report.kill_causes.sort_values("cause_id")
    if causes.empty:
        fig = go.Figure()
        fig.update_layout(
            title="How do kill causes differ across kits?",
            xaxis_title="Kit",
            yaxis_title="Share",
        )
        return fig

    cause_colors = _cause_color_map(report)
    outgoing_order = (
        report.kit_metrics.sort_values(
            ["kills", "kit_id"],
            ascending=[False, True],
        )["kit_name"].tolist()
    )
    incoming_rate_order = (
        report.death_metrics.sort_values(
            ["deaths_per_hour", "deaths", "kit_id"],
            ascending=[False, False, True],
            na_position="last",
        )["kit_name"].tolist()
    )
    incoming_share_order = (
        report.death_metrics.sort_values(
            ["deaths", "kit_id"],
            ascending=[False, True],
        )["kit_name"].tolist()
    )

    modes = (
        {
            "button_label": "Outgoing share",
            "data": report.outgoing_kills_by_cause,
            "value_col": "cause_share_of_kit_kills",
            "order": outgoing_order,
            "title": "How does each kit secure its attributed player kills?",
            "xaxis_title": "Attacking kit",
            "yaxis_title": "Share of attributed kills",
            "tickformat": ".0%",
            "range": [0, 1],
            "custom_cols": [
                "kills",
                "cause_share_of_kit_kills",
                "cause_kills_per_hour",
                "kit_total_kills",
                "total_hours",
            ],
            "hovertemplate": (
                "<b>%{x}</b><br>%{fullData.name}<br>"
                "Share of kit kills: %{y:.1%}<br>"
                "Kills from cause: %{customdata[0]:,.0f}<br>"
                "Cause-specific kills per hour: %{customdata[2]:.2f}<br>"
                "All attributed kit kills: %{customdata[3]:,.0f}<br>"
                "Kit playtime: %{customdata[4]:,.2f} h"
                "<extra></extra>"
            ),
        },
        {
            "button_label": "Incoming deaths / hour",
            "data": report.incoming_deaths_by_cause,
            "value_col": "cause_deaths_per_hour",
            "order": incoming_rate_order,
            "title": "What kills each kit most often per active hour?",
            "xaxis_title": "Victim kit",
            "yaxis_title": "Deaths per active hour",
            "tickformat": ".2f",
            "range": None,
            "custom_cols": [
                "deaths",
                "cause_share_of_kit_deaths",
                "cause_deaths_per_hour",
                "kit_total_deaths",
                "kit_deaths_per_hour",
                "player_caused_deaths",
                "non_player_deaths",
                "non_player_death_share",
                "total_hours",
            ],
            "hovertemplate": (
                "<b>%{x}</b><br>%{fullData.name}<br>"
                "Deaths per hour from cause: %{y:.2f}<br>"
                "Deaths from cause: %{customdata[0]:,.0f}<br>"
                "Share of kit deaths: %{customdata[1]:.1%}<br>"
                "All deaths per hour: %{customdata[4]:.2f}<br>"
                "Player-caused deaths: %{customdata[5]:,.0f}<br>"
                "Non-player deaths: %{customdata[6]:,.0f} "
                "(%{customdata[7]:.1%})<br>"
                "Kit playtime: %{customdata[8]:,.2f} h"
                "<extra></extra>"
            ),
        },
        {
            "button_label": "Incoming share",
            "data": report.incoming_deaths_by_cause,
            "value_col": "cause_share_of_kit_deaths",
            "order": incoming_share_order,
            "title": "What accounts for each kit's observed deaths?",
            "xaxis_title": "Victim kit",
            "yaxis_title": "Share of all deaths while using kit",
            "tickformat": ".0%",
            "range": [0, 1],
            "custom_cols": [
                "deaths",
                "cause_share_of_kit_deaths",
                "cause_deaths_per_hour",
                "kit_total_deaths",
                "kit_deaths_per_hour",
                "player_caused_deaths",
                "non_player_deaths",
                "non_player_death_share",
                "total_hours",
            ],
            "hovertemplate": (
                "<b>%{x}</b><br>%{fullData.name}<br>"
                "Share of kit deaths: %{y:.1%}<br>"
                "Deaths from cause: %{customdata[0]:,.0f}<br>"
                "Cause-specific deaths per hour: "
                "%{customdata[2]:.2f}<br>"
                "All kit deaths: %{customdata[3]:,.0f}<br>"
                "All deaths per hour: %{customdata[4]:.2f}<br>"
                "Non-player death share: %{customdata[7]:.1%}"
                "<extra></extra>"
            ),
        },
    )

    return _stacked_cause_modes_figure(
        causes=causes,
        modes=modes,
        cause_colors=cause_colors,
        legend_title="Kill cause",
    )


def damage_causes_figure(report: ReportData) -> go.Figure:
    """Compare offensive damage identity with defensive vulnerability."""

    causes = report.damage_causes.sort_values("cause_id")
    if causes.empty:
        fig = go.Figure()
        fig.update_layout(
            title="How do damage causes differ across kits?",
            xaxis_title="Kit",
            yaxis_title="Damage",
        )
        return fig

    cause_colors = _cause_color_map(report)
    dealt_rate_order = (
        report.damage_metrics.sort_values(
            ["damage_dealt_per_hour", "damage_dealt", "kit_id"],
            ascending=[False, False, True],
            na_position="last",
        )["kit_name"].tolist()
    )
    # Normalized share bars all have the same height, so keep their kit order
    # stable instead of sorting them by a total that is only visible on hover.
    dealt_share_order = list(KIT_ORDER)
    received_rate_order = (
        report.damage_metrics.sort_values(
            ["damage_received_per_hour", "damage_received", "kit_id"],
            ascending=[False, False, True],
            na_position="last",
        )["kit_name"].tolist()
    )
    received_share_order = list(KIT_ORDER)

    outgoing_custom_cols = [
        "damage_dealt",
        "cause_share_of_kit_damage_dealt",
        "cause_damage_dealt_per_hour",
        "kit_total_damage_dealt",
        "kit_damage_dealt_per_hour",
        "total_hours",
    ]
    incoming_custom_cols = [
        "damage_received",
        "cause_share_of_kit_damage_received",
        "cause_damage_received_per_hour",
        "kit_total_damage_received",
        "kit_damage_received_per_hour",
        "player_damage_received",
        "non_player_damage_received",
        "non_player_damage_received_share",
        "total_hours",
    ]
    modes = (
        {
            "button_label": "Dealt / hour",
            "data": report.outgoing_damage_by_cause,
            "value_col": "cause_damage_dealt_per_hour",
            "order": dealt_rate_order,
            "title": (
                "Which causes drive each kit's attributed damage "
                "per active hour?"
            ),
            "xaxis_title": "Attacking kit",
            "yaxis_title": "Attributed damage dealt per hour (hearts)",
            "tickformat": ",.1f",
            "range": None,
            "custom_cols": outgoing_custom_cols,
            "hovertemplate": (
                "<b>%{x}</b><br>%{fullData.name}<br>"
                "Cause damage per hour: %{y:,.1f} hearts<br>"
                "Cause damage: %{customdata[0]:,.1f} hearts<br>"
                "Share of kit damage: %{customdata[1]:.1%}<br>"
                "All kit damage per hour: %{customdata[4]:,.1f} hearts<br>"
                "All attributed kit damage: %{customdata[3]:,.1f} hearts<br>"
                "Kit playtime: %{customdata[5]:,.2f} h"
                "<extra></extra>"
            ),
        },
        {
            "button_label": "Dealt share",
            "data": report.outgoing_damage_by_cause,
            "value_col": "cause_share_of_kit_damage_dealt",
            "order": dealt_share_order,
            "title": "How does each kit deal its attributed player damage?",
            "xaxis_title": "Attacking kit",
            "yaxis_title": "Share of attributed damage dealt",
            "tickformat": ".0%",
            "range": [0, 1],
            "custom_cols": outgoing_custom_cols,
            "hovertemplate": (
                "<b>%{x}</b><br>%{fullData.name}<br>"
                "Share of kit damage: %{y:.1%}<br>"
                "Cause damage: %{customdata[0]:,.1f} hearts<br>"
                "Cause damage per hour: %{customdata[2]:,.1f} hearts<br>"
                "All attributed kit damage: %{customdata[3]:,.1f} hearts<br>"
                "All kit damage per hour: %{customdata[4]:,.1f} hearts"
                "<extra></extra>"
            ),
        },
        {
            "button_label": "Received / hour",
            "data": report.incoming_damage_by_cause,
            "value_col": "cause_damage_received_per_hour",
            "order": received_rate_order,
            "title": "What causes the most damage to each kit per active hour?",
            "xaxis_title": "Target kit",
            "yaxis_title": "Damage received per hour (hearts)",
            "tickformat": ",.1f",
            "range": None,
            "custom_cols": incoming_custom_cols,
            "hovertemplate": (
                "<b>%{x}</b><br>%{fullData.name}<br>"
                "Cause damage per hour: %{y:,.1f} hearts<br>"
                "Cause damage received: %{customdata[0]:,.1f} hearts<br>"
                "Share of received damage: %{customdata[1]:.1%}<br>"
                "All received damage per hour: %{customdata[4]:,.1f} hearts<br>"
                "Player damage received: %{customdata[5]:,.1f} hearts<br>"
                "Non-player damage: %{customdata[6]:,.1f} hearts "
                "(%{customdata[7]:.1%})<br>Kit playtime: "
                "%{customdata[8]:,.2f} h<extra></extra>"
            ),
        },
        {
            "button_label": "Received share",
            "data": report.incoming_damage_by_cause,
            "value_col": "cause_share_of_kit_damage_received",
            "order": received_share_order,
            "title": "What makes up each kit's received damage?",
            "xaxis_title": "Target kit",
            "yaxis_title": "Share of damage received",
            "tickformat": ".0%",
            "range": [0, 1],
            "custom_cols": incoming_custom_cols,
            "hovertemplate": (
                "<b>%{x}</b><br>%{fullData.name}<br>"
                "Share of received damage: %{y:.1%}<br>"
                "Cause damage received: %{customdata[0]:,.1f} hearts<br>"
                "Cause damage per hour: %{customdata[2]:,.1f} hearts<br>"
                "All damage received: %{customdata[3]:,.1f} hearts<br>"
                "All received damage per hour: %{customdata[4]:,.1f} hearts<br>"
                "Non-player damage share: %{customdata[7]:.1%}"
                "<extra></extra>"
            ),
        },
    )
    return _stacked_cause_modes_figure(
        causes=causes,
        modes=modes,
        cause_colors=cause_colors,
        legend_title="Damage cause",
    )


def popularity_efficiency_figure(report: ReportData) -> go.Figure:
    """Relate kill efficiency to popularity and player Elo composition."""

    elo_name = _elo_name(report)
    columns = [
        "kit_name",
        "kit_id",
        "time_share",
        "kills_per_hour",
        "kills_per_completed_life",
        "player_reach",
        "players_with_time",
        "total_hours",
        "completed_lives",
        "kills",
        "playtime_weighted_player_elo",
        "overall_playtime_weighted_player_elo",
        "player_elo_difference_from_overall",
        "rated_player_time_share",
        "players_with_rated_encounters",
        "median_player_rated_encounters",
    ]
    plot_data = (
        report.kit_metrics[columns]
        .replace([np.inf, -np.inf], np.nan)
        .dropna(subset=["time_share", "kills_per_hour"])
        .copy()
    )
    total_hours = float(report.kit_metrics["total_hours"].sum())
    overall_kill_rate = (
        float(report.kit_metrics["kills"].sum()) / total_hours
        if total_hours > 0
        else np.nan
    )
    elo_reference_values = plot_data[
        "overall_playtime_weighted_player_elo"
    ].dropna()
    if report.elo_metadata.empty or elo_reference_values.empty:
        return _quadrant_scatter_figure(
            plot_data,
            x_col="time_share",
            y_col="kills_per_hour",
            title="Are the most-played kits also the most kill-efficient?",
            labels={
                "time_share": "Share of kit playtime",
                "kills_per_hour": "Kills per active hour",
                "kills_per_completed_life": "Kills per completed life",
                "player_reach": "Proportion of players who tried the kit",
                "players_with_time": "Players with playtime",
                "total_hours": "Time played (hours)",
                "completed_lives": "Completed lives",
                "kills": "Total kills",
                "kit_name": "Kit",
            },
            hover_data={
                "time_share": ":.1%",
                "kills_per_hour": ":.2f",
                "kills_per_completed_life": ":.2f",
                "player_reach": ":.1%",
                "players_with_time": True,
                "total_hours": ":.2f",
                "completed_lives": True,
                "kills": True,
                "kit_name": False,
            },
            quadrant_labels=(
                "Lower playtime<br>higher kill rate",
                "Higher playtime<br>higher kill rate",
                "Lower playtime<br>lower kill rate",
                "Higher playtime<br>lower kill rate",
            ),
            x_tickformat=".0%",
            x_reference=1 / len(KIT_NAMES),
            y_reference=overall_kill_rate,
            x_upper_bound=1,
            x_padding_fraction=0.12,
            x_minimum_padding=0.01,
            y_padding_fraction=0.12,
            y_minimum_padding=0.05,
        )

    overall_elo = float(elo_reference_values.iloc[0])
    customdata_cols = (
        "time_share",
        "kills_per_hour",
        "kills_per_completed_life",
        "player_reach",
        "players_with_time",
        "total_hours",
        "completed_lives",
        "kills",
        "playtime_weighted_player_elo",
        "overall_playtime_weighted_player_elo",
        "player_elo_difference_from_overall",
        "rated_player_time_share",
        "players_with_rated_encounters",
        "median_player_rated_encounters",
    )
    return _quadrant_modes_figure(
        plot_data,
        customdata_cols=customdata_cols,
        modes=(
            QuadrantMode(
                button_label="Popularity",
                x_col="time_share",
                y_col="kills_per_hour",
                title=(
                    "Are the most-played kits also the most kill-efficient?"
                ),
                xaxis_title="Share of kit playtime",
                yaxis_title="Kills per active hour",
                x_tickformat=".0%",
                y_tickformat=".2f",
                x_reference=1 / len(KIT_NAMES),
                y_reference=overall_kill_rate,
                x_upper_bound=1,
                x_padding_fraction=0.12,
                y_padding_fraction=0.12,
                y_minimum_padding=0.05,
                quadrant_labels=(
                    "Lower playtime<br>higher kill rate",
                    "Higher playtime<br>higher kill rate",
                    "Lower playtime<br>lower kill rate",
                    "Higher playtime<br>lower kill rate",
                ),
                hovertemplate=(
                    "<b>%{fullData.name}</b><br>Playtime share: "
                    "%{x:.1%}<br>Kills per hour: %{y:.2f}<br>"
                    "Kills per completed life: %{customdata[2]:.2f}<br>"
                    "Player reach: %{customdata[3]:.1%}<br>"
                    "Players with playtime: %{customdata[4]:,.0f}<br>"
                    "Time played: %{customdata[5]:,.2f} h<br>"
                    "Completed lives: %{customdata[6]:,.0f}<br>"
                    "Total kills: %{customdata[7]:,.0f}<extra></extra>"
                ),
            ),
            QuadrantMode(
                button_label="Player Elo",
                x_col="playtime_weighted_player_elo",
                y_col="kills_per_hour",
                title=(
                    "Are kits with higher kill rates disproportionately "
                    "played by higher-rated players?"
                ),
                xaxis_title=f"Playtime-weighted player {elo_name}",
                yaxis_title="Kills per active hour",
                x_tickformat=",.0f",
                y_tickformat=".2f",
                x_reference=overall_elo,
                y_reference=overall_kill_rate,
                x_lower_bound=None,
                x_padding_fraction=0.12,
                y_padding_fraction=0.12,
                y_minimum_padding=0.05,
                quadrant_labels=(
                    "Below-overall Elo<br>higher kill rate",
                    "Above-overall Elo<br>higher kill rate",
                    "Below-overall Elo<br>lower kill rate",
                    "Above-overall Elo<br>lower kill rate",
                ),
                hovertemplate=(
                    "<b>%{fullData.name}</b><br>Playtime-weighted "
                    f"{elo_name}: %{{x:,.2f}}<br>Difference from overall: "
                    "%{customdata[10]:+.2f}<br>Overall observed "
                    f"{elo_name}: %{{customdata[9]:,.2f}}<br>"
                    "Rated playtime: "
                    "%{customdata[11]:.1%}<br>Players with rated "
                    "encounters: %{customdata[12]:,.0f} / "
                    "%{customdata[4]:,.0f}<br>Median rated encounters: "
                    "%{customdata[13]:,.0f}<br>Kills per hour: "
                    "%{y:.2f}<br>Kills per completed life: "
                    "%{customdata[2]:.2f}<br>Total kills: "
                    "%{customdata[7]:,.0f}<br>Time played: "
                    "%{customdata[5]:,.2f} h<extra></extra>"
                ),
            ),
        ),
    )


def ability_uses_figure(report: ReportData) -> go.Figure:
    """Build activation, player-contribution, and success-rate modes."""

    totals = report.kit_metrics.copy()
    totals["ability_effect_per_success_text"] = (
        _ability_effect_per_success_text(totals)
    )
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
        ),
        metric_views=(
            AggregateMetricView(
                button_label="Total uses",
                value_col="ability_use",
                title="Which abilities were activated most often?",
                yaxis_title="Ability uses",
                tickformat=",.0f",
                hovertemplate=(
                    "<b>%{x}</b><br>Ability uses: %{y:,.0f}<br>"
                    "Time played: %{customdata[1]:,.2f} h<br>"
                    "Completed lives: %{customdata[2]:,.0f}<br>"
                    "Players with playtime: %{customdata[3]:,.0f}<br>"
                    "Cooldown: %{customdata[6]:.1f} s<br>"
                    "Cooldown-normalized rate: %{customdata[9]:.1%}"
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
                    "<b>%{x}</b><br>Cooldown-normalized rate: "
                    "%{y:.1%}<br>Median player rate: "
                    "%{customdata[10]:.1%}<br>Observed uses per hour: "
                    "%{customdata[8]:.2f}<br>Cooldown-only maximum: "
                    "%{customdata[7]:.2f} uses / h<br>Cooldown: "
                    "%{customdata[6]:.1f} s<br>Total uses: "
                    "%{customdata[0]:,.0f}<br>Time played: "
                    "%{customdata[1]:,.2f} h"
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
                    "%{y:.1%}<br>Median eligible player: "
                    "%{customdata[13]:.1%}<br>Successful uses: "
                    "%{customdata[11]:,.0f} / %{customdata[0]:,.0f}<br>"
                    "Cooldown-normalized activation: "
                    "%{customdata[9]:.1%}<br>Effect metric: "
                    "%{customdata[15]}<br>Effectiveness: "
                    "%{customdata[20]}<br>"
                    "%{customdata[18]}<extra></extra>"
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
                    "<b>%{x}</b><br>Ability uses per completed life: "
                    "%{y:.2f}<br>Median player rate: "
                    "%{customdata[5]:.2f}<br>Total uses: "
                    "%{customdata[0]:,.0f}<br>"
                    "Completed lives: %{customdata[2]:,.0f}<br>"
                    "Cooldown: %{customdata[6]:.1f} s<br>"
                    "Cooldown-normalized rate: %{customdata[9]:.1%}"
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
                    "Median eligible player: %{customdata[13]:.1%} "
                    "(%{customdata[12]:,.0f} players)<br>"
                    "Uses per hour: %{customdata[4]:.2f}<br>Effect metric: "
                    "%{customdata[8]}<br>Effectiveness: "
                    "%{customdata[16]}<br>"
                    "%{customdata[9]}<extra></extra>"
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
                    "%{customdata[5]:,.0f}<br>Median eligible player: "
                    "%{customdata[15]:.2f} players / success "
                    "(%{customdata[14]:,.0f} players)<br>%{customdata[9]}"
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
                    "%{customdata[8]} per successful use: %{y:.2f} hearts<br>"
                    "Successful-use rate: %{customdata[2]:.1%}<br>"
                    "Successful uses: %{customdata[1]:,.0f} / "
                    "%{customdata[0]:,.0f}<br>Total health impact: "
                    "%{customdata[5]:,.1f} hearts<br>Median eligible player: "
                    "%{customdata[15]:.2f} hearts / success "
                    "(%{customdata[14]:,.0f} players)<br>%{customdata[9]}"
                    "<extra></extra>"
                ),
            ),
        ),
    )


def player_reach_figure(report: ReportData) -> go.Figure:
    """Combine direct adoption, kill reach, exposure shares, and life duration."""

    plot_data = report.reach.merge(
        report.kit_metrics[
            [
                "kit_name",
                "total_hours",
                "completed_lives",
                "players_with_completed_life",
                "time_share",
                "completed_life_share",
                "hours_per_completed_life",
            ]
        ],
        on="kit_name",
        how="left",
    )
    denominator = np.full(len(plot_data), report.n_players)
    kit_colors = plot_data["kit_name"].map(KIT_COLORS)

    fig = go.Figure()

    # Wide, faded bars show direct adoption.  The narrower solid bars nested
    # inside them show the subset that managed at least one player kill.
    fig.add_trace(
        go.Bar(
            x=plot_data["kit_name"],
            y=plot_data["played"],
            width=0.82,
            name="Tried the kit",
            marker={
                "color": kit_colors,
                "line": {"color": "#333333", "width": 1},
            },
            opacity=0.32,
            customdata=np.column_stack(
                [
                    plot_data["played_count"],
                    denominator,
                    plot_data["used_ability"],
                    plot_data["used_ability_count"],
                    plot_data["total_hours"],
                    plot_data["completed_lives"],
                ]
            ),
            visible=True,
            hovertemplate=(
                "<b>%{x}</b><br>Players who tried it: %{y:.1%}<br>"
                "Players: %{customdata[0]:.0f} / %{customdata[1]:.0f}<br>"
                "Used its ability: %{customdata[2]:.1%} "
                "(%{customdata[3]:.0f} players)<br>"
                "Time played: %{customdata[4]:,.2f} h<br>"
                "Completed lives: %{customdata[5]:,.0f}<extra></extra>"
            ),
        )
    )
    fig.add_trace(
        go.Bar(
            x=plot_data["kit_name"],
            y=plot_data["made_kill"],
            width=0.42,
            name="Made ≥1 player kill",
            marker={
                "color": kit_colors,
                "line": {"color": "#222222", "width": 1.2},
            },
            customdata=np.column_stack(
                [plot_data["made_kill_count"], denominator]
            ),
            visible=True,
            hovertemplate=(
                "<b>%{x}</b><br>Made a player kill: %{y:.1%}<br>"
                "Players: %{customdata[0]:.0f} / %{customdata[1]:.0f}"
                "<extra></extra>"
            ),
        )
    )

    exposure_order = plot_data.sort_values(
        "time_share",
        ascending=False,
        na_position="last",
    ).reset_index(drop=True)
    for _, row in exposure_order.iterrows():
        fig.add_trace(
            go.Bar(
                x=[row["time_share"], row["completed_life_share"]],
                y=["Playtime", "Completed lives"],
                orientation="h",
                name=row["kit_name"],
                legendgroup=row["kit_name"],
                marker={
                    "color": KIT_COLORS[row["kit_name"]],
                    "line": {"color": "#333333", "width": 0.7},
                },
                customdata=[
                    [f'{row["total_hours"]:,.2f} h'],
                    [f'{row["completed_lives"]:,.0f} lives'],
                ],
                visible=False,
                hovertemplate=(
                    "<b>%{fullData.name}</b><br>%{y} share: %{x:.1%}<br>"
                    "Observed total: %{customdata[0]}<extra></extra>"
                ),
            )
        )

    fig.add_trace(
        go.Bar(
            x=plot_data["kit_name"],
            y=plot_data["hours_per_completed_life"] * 60,
            name="Average life duration",
            marker={
                "color": kit_colors,
                "line": {"color": "#333333", "width": 1},
            },
            customdata=np.column_stack(
                [
                    plot_data["total_hours"],
                    plot_data["completed_lives"],
                    plot_data["players_with_completed_life"],
                ]
            ),
            showlegend=False,
            visible=False,
            hovertemplate=(
                "<b>%{x}</b><br>Time per completed life: %{y:.2f} min<br>"
                "Time played: %{customdata[0]:,.2f} h<br>"
                "Completed lives: %{customdata[1]:,.0f}<br>"
                "Players: %{customdata[2]:,.0f}<extra></extra>"
            ),
        )
    )

    exposure_trace_count = len(exposure_order)
    life_trace_index = 2 + exposure_trace_count
    player_visibility = [True, True] + [False] * (
        exposure_trace_count + 1
    )
    exposure_visibility = [False, False] + [True] * exposure_trace_count + [
        False
    ]
    life_visibility = [False] * life_trace_index + [True]

    player_layout = {
        "title": {
            "text": (
                "Which kits reached the largest share of observed players?"
            )
        },
        "barmode": "overlay",
        "height": 520,
        "xaxis": {
            "title": {"text": "Kit"},
            "type": "category",
            "categoryorder": "array",
            "categoryarray": list(KIT_ORDER),
            "range": None,
            "autorange": True,
            "tickformat": "",
        },
        "yaxis": {
            "title": {"text": "Proportion of players"},
            "type": "linear",
            "tickformat": ".0%",
            "range": [0, 1],
            "autorange": False,
        },
        "legend": {
            "title": {"text": "Player reach"},
            "orientation": "h",
            "x": 0.5,
            "xanchor": "center",
            "y": -0.18,
            "yanchor": "top",
        },
    }
    exposure_layout = {
        "title": {
            "text": (
                "How is observed playtime and completed-life exposure "
                "distributed across kits?"
            )
        },
        "barmode": "stack",
        "height": 430,
        "xaxis": {
            "title": {"text": "Share of observed total"},
            "type": "linear",
            "tickformat": ".0%",
            "range": [0, 1],
            "autorange": False,
        },
        "yaxis": {
            "title": {"text": ""},
            "type": "category",
            "categoryorder": "array",
            "categoryarray": ["Completed lives", "Playtime"],
            "range": None,
            "autorange": True,
        },
        "legend": {
            "title": {"text": "Kit (playtime-share order)"},
            "orientation": "h",
            "x": 0.5,
            "xanchor": "center",
            "y": -0.30,
            "yanchor": "top",
        },
    }
    life_layout = {
        "title": {
            "text": (
                "Which kits accumulated the most observed playtime per "
                "completed life?"
            )
        },
        "barmode": "group",
        "height": 520,
        "xaxis": {
            "title": {"text": "Kit"},
            "type": "category",
            "categoryorder": "array",
            "categoryarray": list(KIT_ORDER),
            "range": None,
            "autorange": True,
            "tickformat": "",
        },
        "yaxis": {
            "title": {"text": "Minutes per completed life"},
            "type": "linear",
            "tickformat": ".1f",
            "range": None,
            "autorange": True,
            "rangemode": "tozero",
        },
        "legend": {
            "orientation": "h",
            "x": 0.5,
            "xanchor": "center",
            "y": -0.18,
            "yanchor": "top",
        },
    }

    fig.update_layout(
        **player_layout,
        margin=dict(l=70, r=35, t=125, b=115),
        hovermode="closest",
        updatemenus=[
            {
                "type": "buttons",
                "direction": "right",
                "x": 0.5,
                "xanchor": "center",
                "y": 1.20,
                "yanchor": "top",
                "showactive": True,
                "buttons": [
                    {
                        "label": "Players who tried",
                        "method": "update",
                        "args": [
                            {"visible": player_visibility},
                            player_layout,
                        ],
                    },
                    {
                        "label": "Exposure shares",
                        "method": "update",
                        "args": [
                            {"visible": exposure_visibility},
                            exposure_layout,
                        ],
                    },
                    {
                        "label": "Life duration",
                        "method": "update",
                        "args": [
                            {"visible": life_visibility},
                            life_layout,
                        ],
                    },
                ],
            }
        ],
    )
    return fig


def kill_concentration_figure(report: ReportData) -> go.Figure:
    """Compare output and exposure concentration across players."""

    return concentration_figure(
        report.summary,
        views=(
            ConcentrationView(
                button_label="Kills",
                total_col="kills",
                top_player_col="top_player_share",
                top_three_col="top_3_share",
                players_col="players_with_kills",
                title="How concentrated is each kit's kill output among players?",
                yaxis_title="Share of kit kills",
            ),
            ConcentrationView(
                button_label="Damage dealt",
                total_col="damage_dealt",
                top_player_col="top_player_damage_share",
                top_three_col="top_3_damage_share",
                players_col="players_dealing_damage",
                title=(
                    "How concentrated is each kit's attributed damage "
                    "among players?"
                ),
                yaxis_title="Share of attributed damage dealt",
            ),
            ConcentrationView(
                button_label="Damage received",
                total_col="damage_received",
                top_player_col="top_player_received_damage_share",
                top_three_col="top_3_received_damage_share",
                players_col="players_receiving_damage",
                title=(
                    "How concentrated is each kit's received damage "
                    "among players?"
                ),
                yaxis_title="Share of all damage received",
            ),
            ConcentrationView(
                button_label="Playtime",
                total_col="total_time",
                top_player_col="top_player_time_share",
                top_three_col="top_3_time_share",
                players_col="players_contributing_time",
                title="How concentrated is each kit's playtime among players?",
                yaxis_title="Share of kit playtime",
            ),
            ConcentrationView(
                button_label="Completed lives",
                total_col="completed_lives",
                top_player_col="top_player_completed_life_share",
                top_three_col="top_3_completed_life_share",
                players_col="players_contributing_completed_lives",
                title=(
                    "How concentrated are each kit's completed lives "
                    "among its players?"
                ),
                yaxis_title="Share of completed lives",
            ),
        ),
    )


def kill_concentration_scatter_figure(report: ReportData) -> go.Figure:
    """Relate kill volume to concentration, with exposure context on hover."""

    plot_data = report.summary.loc[
        report.summary["kills"] > 0,
        [
            "kit_name",
            "kills",
            "kills_per_hour",
            "kills_per_completed_life",
            "time_share",
            "total_hours",
            "completed_lives",
            "players_with_kills",
            "top_player_share",
            "top_3_share",
        ],
    ].copy()

    return _quadrant_scatter_figure(
        plot_data,
        x_col="kills",
        y_col="top_player_share",
        title="How does kill volume relate to dependence on the top player?",
        labels={
            "kills": "Total kills",
            "kills_per_hour": "Kills per hour",
            "kills_per_completed_life": "Kills per completed life",
            "time_share": "Share of kit playtime",
            "total_hours": "Time played (hours)",
            "completed_lives": "Completed lives",
            "top_player_share": "Top player's share of kit kills",
            "players_with_kills": "Players with kills",
            "top_3_share": "Top 3 players' share",
            "kit_name": "Kit",
        },
        hover_data={
            "kills": True,
            "kills_per_hour": ":.2f",
            "kills_per_completed_life": ":.2f",
            "time_share": ":.1%",
            "total_hours": ":.2f",
            "completed_lives": True,
            "players_with_kills": True,
            "top_player_share": ":.1%",
            "top_3_share": ":.1%",
            "kit_name": False,
        },
        quadrant_labels=(
            "Low kills<br>player-driven",
            "High kills<br>player-driven",
            "Low kills<br>broad contribution",
            "High kills<br>broad contribution",
        ),
        y_tickformat=".0%",
        y_upper_bound=1,
        y_padding_fraction=0.12,
        y_minimum_padding=0.025,
    )


def top_killer_exposure_figure(report: ReportData) -> go.Figure:
    """Compare selected players' kill shares with their exposure shares."""

    elo_available = not report.elo_metadata.empty
    elo_name = _elo_name(report)
    views = (
        {
            "button_label": "Top killer",
            "title": (
                "Does each kit's top killer contribute more kills than "
                "their playtime share suggests?"
            ),
            "player_label": "Top killer",
            "counterpart_label": "Top playtime player",
            "prefix": "top_killer",
            "xaxis_title": "Top killer's share of kit playtime",
            "yaxis_title": "Top killer's share of kit kills",
        },
        {
            "button_label": "Top playtime",
            "title": (
                "Does each kit's most-played player contribute kills in "
                "proportion to their playtime?"
            ),
            "player_label": "Top playtime player",
            "counterpart_label": "Top killer",
            "prefix": "top_playtime_player",
            "xaxis_title": (
                "Top playtime player's share of kit playtime"
            ),
            "yaxis_title": "Top playtime player's share of kit kills",
        },
    )
    source = report.top_killer_exposure.replace(
        [np.inf, -np.inf], np.nan
    )
    available_views = []
    for view in views:
        prefix = view["prefix"]
        plot_data = source.dropna(
            subset=[f"{prefix}_kill_share", f"{prefix}_time_share"]
        ).copy()
        if not plot_data.empty:
            available_views.append((view, plot_data))

    first_view = available_views[0][0] if available_views else views[0]
    if not available_views:
        fig = go.Figure()
        fig.update_layout(title=first_view["title"])
        fig.update_xaxes(
            title=first_view["xaxis_title"],
            tickformat=".0%",
            range=[0, 1],
        )
        fig.update_yaxes(
            title=first_view["yaxis_title"],
            tickformat=".0%",
            range=[0, 1],
        )
        return fig

    share_values = pd.concat(
        [
            plot_data[f"{view['prefix']}_{share_kind}_share"]
            for view, plot_data in available_views
            for share_kind in ("time", "kill")
        ],
        ignore_index=True,
    )
    shared_range = _padded_axis_range(
        share_values,
        padding_fraction=0.12,
        minimum_padding=0.025,
        upper_bound=1,
    )

    fig = go.Figure()
    trace_view_indices = []
    for view_index, (view, plot_data) in enumerate(available_views):
        prefix = view["prefix"]
        counterpart_prefix = (
            "top_playtime_player"
            if prefix == "top_killer"
            else "top_killer"
        )
        for row in plot_data.itertuples(index=False):
            customdata_values = [
                getattr(row, f"{prefix}_id"),
                getattr(row, f"{prefix}_kills"),
                getattr(row, f"{prefix}_hours"),
                getattr(row, f"{prefix}_completed_lives"),
                getattr(row, f"{prefix}_kills_per_hour"),
                getattr(row, f"{prefix}_kills_per_completed_life"),
                getattr(row, f"{prefix}_kill_share_minus_time_share"),
                getattr(row, f"{prefix}_kill_to_time_share_ratio"),
                row.kit_kills,
                row.kit_total_hours,
                row.kit_players_with_time,
                getattr(row, f"{counterpart_prefix}_id"),
                (
                    "Yes"
                    if row.same_top_killer_and_playtime_player
                    else "No"
                ),
            ]
            if elo_available:
                customdata_values.extend(
                    [
                        getattr(row, f"{prefix}_rating"),
                        getattr(row, f"{prefix}_rated_encounters"),
                        getattr(row, f"{counterpart_prefix}_rating"),
                        getattr(
                            row,
                            f"{counterpart_prefix}_rated_encounters",
                        ),
                    ]
                )
            customdata = [customdata_values]
            selected_elo_hover = (
                f"Selected-player {elo_name}: "
                "%{customdata[13]:,.2f}<br>"
                "Selected-player rated encounters: "
                "%{customdata[14]:,.0f}<br>"
                if elo_available
                else ""
            )
            counterpart_elo_hover = (
                f"Counterpart {elo_name}: "
                "%{customdata[15]:,.2f}<br>"
                "Counterpart rated encounters: "
                "%{customdata[16]:,.0f}<br>"
                if elo_available
                else ""
            )
            fig.add_trace(
                go.Scatter(
                    x=[getattr(row, f"{prefix}_time_share")],
                    y=[getattr(row, f"{prefix}_kill_share")],
                    mode="markers",
                    name=row.kit_name,
                    legendgroup=row.kit_name,
                    marker=dict(
                        size=12,
                        color=KIT_COLORS[row.kit_name],
                        line=dict(color="#333333", width=1),
                    ),
                    customdata=customdata,
                    visible=view_index == 0,
                    hovertemplate=(
                        f"<b>{row.kit_name}</b><br>"
                        f"{view['player_label']}: %{{customdata[0]}}<br>"
                        "Kill share: %{y:.1%}<br>"
                        "Playtime share: %{x:.1%}<br>"
                        "Kill-share advantage: %{customdata[6]:+.1%}<br>"
                        "Kill / playtime share ratio: "
                        "%{customdata[7]:.2f}<br>"
                        "Selected-player kills: %{customdata[1]:,.0f}<br>"
                        "Selected-player playtime: "
                        "%{customdata[2]:,.2f} h<br>"
                        "Selected-player completed lives: "
                        "%{customdata[3]:,.0f}<br>"
                        "Selected-player kills / hour: "
                        "%{customdata[4]:.2f}<br>"
                        "Selected-player kills / life: "
                        "%{customdata[5]:.2f}<br>"
                        + selected_elo_hover
                        + f"{view['counterpart_label']}: "
                        "%{customdata[11]}<br>"
                        + counterpart_elo_hover
                        + "Same player in both modes: "
                        "%{customdata[12]}<br>"
                        "Kit kills: %{customdata[8]:,.0f}<br>"
                        "Kit playtime: %{customdata[9]:,.2f} h<br>"
                        "Kit players with playtime: "
                        "%{customdata[10]:,.0f}<extra></extra>"
                    ),
                )
            )
            trace_view_indices.append(view_index)

    fig.add_shape(
        type="line",
        x0=shared_range[0],
        y0=shared_range[0],
        x1=shared_range[1],
        y1=shared_range[1],
        line=dict(color="#555555", width=2, dash="dash"),
        layer="below",
    )
    axis_span = shared_range[1] - shared_range[0]
    for x_fraction, y_fraction, label in (
        (0.24, 0.76, "Kill share exceeds<br>playtime share"),
        (0.76, 0.24, "Playtime share exceeds<br>kill share"),
    ):
        fig.add_annotation(
            x=shared_range[0] + x_fraction * axis_span,
            y=shared_range[0] + y_fraction * axis_span,
            text=label,
            showarrow=False,
            font=dict(size=11, color="#555555"),
            bgcolor="rgba(255,255,255,0.72)",
        )

    updatemenus = []
    if len(available_views) > 1:
        updatemenus = [
            {
                "type": "buttons",
                "direction": "right",
                "x": 0.5,
                "xanchor": "center",
                "y": 1.16,
                "yanchor": "top",
                "showactive": True,
                "buttons": [
                    {
                        "label": view["button_label"],
                        "method": "update",
                        "args": [
                            {
                                "visible": [
                                    trace_view_index == view_index
                                    for trace_view_index in trace_view_indices
                                ]
                            },
                            {
                                "title": {"text": view["title"]},
                                "xaxis": {
                                    "title": {
                                        "text": view["xaxis_title"]
                                    },
                                    "tickformat": ".0%",
                                    "range": shared_range,
                                    "constrain": "domain",
                                },
                                "yaxis": {
                                    "title": {
                                        "text": view["yaxis_title"]
                                    },
                                    "tickformat": ".0%",
                                    "range": shared_range,
                                    "scaleanchor": "x",
                                    "scaleratio": 1,
                                },
                            },
                        ],
                    }
                    for view_index, (view, _) in enumerate(available_views)
                ],
            }
        ]

    fig.update_layout(
        title=first_view["title"],
        height=650,
        legend_title_text="Kit",
        margin=dict(l=70, r=35, t=125, b=70),
        updatemenus=updatemenus,
    )
    fig.update_xaxes(
        title=first_view["xaxis_title"],
        tickformat=".0%",
        range=shared_range,
        constrain="domain",
    )
    fig.update_yaxes(
        title=first_view["yaxis_title"],
        tickformat=".0%",
        range=shared_range,
        scaleanchor="x",
        scaleratio=1,
    )
    return fig


def matchup_figure(
    matchup_matrix: pd.DataFrame,
    directional_share: np.ndarray,
    pair_totals: np.ndarray,
    matchup_kills_by_cause: pd.DataFrame,
    *,
    damage_matchup_matrix: pd.DataFrame | None = None,
    damage_directional_share: np.ndarray | None = None,
    damage_pair_totals: np.ndarray | None = None,
    matchup_damage_by_cause: pd.DataFrame | None = None,
) -> go.Figure:
    """Toggle kill and damage evidence between kit pairs."""

    kill_share_display = directional_share.copy()
    kill_share_display[np.tril_indices(len(KIT_NAMES))] = np.nan
    kill_share_hover = np.full_like(directional_share, "", dtype=object)
    raw_kill_hover = np.full_like(directional_share, "", dtype=object)
    kill_cause_lookup: dict[tuple[int, int], str] = {}
    for pair, group in matchup_kills_by_cause.groupby(
        ["kit_id_killer", "kit_id_victim"]
    ):
        group = group.sort_values("cause_id")
        pair_total = int(group["kills"].sum())
        if pair_total <= 0:
            continue
        kill_cause_lookup[(int(pair[0]), int(pair[1]))] = "<br>".join(
            f"{row.cause_name}: {row.kills:,} "
            f"({row.kills / pair_total:.1%})"
            for row in group.itertuples(index=False)
        )

    for killer_id, killer_name in enumerate(KIT_NAMES):
        for victim_id, victim_name in enumerate(KIT_NAMES):
            kill_count = int(matchup_matrix.iloc[killer_id, victim_id])
            if not kill_count:
                raw_kill_hover[killer_id, victim_id] = (
                    f"<b>{killer_name} → {victim_name}</b><br>"
                    "No attributed kills observed"
                )
                continue
            raw_kill_hover[killer_id, victim_id] = (
                f"<b>{killer_name} → {victim_name}</b><br>"
                f"Kills: {kill_count:,}<br><br>"
                "<b>Cause breakdown</b><br>"
                f"{kill_cause_lookup.get((killer_id, victim_id), 'Unavailable')}"
            )

    for i, row_kit in enumerate(KIT_NAMES):
        for j, column_kit in enumerate(KIT_NAMES):
            if i >= j:
                continue

            if np.isnan(directional_share[i, j]):
                kill_share_hover[i, j] = (
                    f"{row_kit} vs {column_kit}<br>"
                    "No kills observed in either direction"
                )
                continue

            kill_share_hover[i, j] = (
                f"<b>{row_kit} vs {column_kit}</b><br>"
                f"{row_kit} kills: {int(matchup_matrix.iloc[i, j]):,}<br>"
                f"{column_kit} kills: "
                f"{int(matchup_matrix.iloc[j, i]):,}<br>"
                f"{row_kit} directional share: "
                f"{directional_share[i, j]:.1%}<br>"
                f"Pair kills observed: {int(pair_totals[i, j]):,}<br><br>"
                f"<b>{row_kit} → {column_kit} causes</b><br>"
                f"{kill_cause_lookup.get((i, j), 'No attributed kills')}"
                "<br><br>"
                f"<b>{column_kit} → {row_kit} causes</b><br>"
                f"{kill_cause_lookup.get((j, i), 'No attributed kills')}"
            )

    fig = go.Figure()
    fig.add_trace(
        go.Heatmap(
            z=kill_share_display,
            x=KIT_ORDER,
            y=KIT_ORDER,
            zmin=0,
            zmax=1,
            zmid=0.5,
            colorscale=[
                [0, "#D08B37"],
                [0.5, "#F4F1EA"],
                [1, "#2A7F7A"],
            ],
            customdata=kill_share_hover,
            hovertemplate="%{customdata}<extra></extra>",
            hoverongaps=False,
            colorbar=dict(
                title="Row kit share",
                tickformat=".0%",
                tickvals=[0, 0.5, 1],
            ),
            visible=True,
        )
    )
    fig.add_trace(
        go.Heatmap(
            z=matchup_matrix.values,
            x=KIT_ORDER,
            y=KIT_ORDER,
            text=matchup_matrix.values,
            texttemplate="%{text}",
            textfont=dict(size=10),
            customdata=raw_kill_hover,
            hovertemplate="%{customdata}<extra></extra>",
            colorbar=dict(title="Kills"),
            visible=False,
        )
    )

    has_damage = (
        damage_matchup_matrix is not None
        and damage_directional_share is not None
        and damage_pair_totals is not None
        and matchup_damage_by_cause is not None
        and float(damage_matchup_matrix.to_numpy().sum()) > 0
    )
    if has_damage:
        damage_share_display = damage_directional_share.copy()
        damage_share_display[np.tril_indices(len(KIT_NAMES))] = np.nan
        damage_share_hover = np.full_like(
            damage_directional_share,
            "",
            dtype=object,
        )
        raw_damage_hover = np.full_like(
            damage_directional_share,
            "",
            dtype=object,
        )
        damage_cause_lookup: dict[tuple[int, int], str] = {}
        for pair, group in matchup_damage_by_cause.groupby(
            ["kit_id_source", "kit_id_target"]
        ):
            group = group.sort_values("cause_id")
            pair_total = float(group["damage_received"].sum())
            if pair_total <= 0:
                continue
            damage_cause_lookup[(int(pair[0]), int(pair[1]))] = "<br>".join(
                f"{row.cause_name}: {row.damage_received:,.1f} hearts "
                f"({row.damage_received / pair_total:.1%})"
                for row in group.itertuples(index=False)
            )

        for source_id, source_name in enumerate(KIT_NAMES):
            for target_id, target_name in enumerate(KIT_NAMES):
                damage_value = float(
                    damage_matchup_matrix.iloc[source_id, target_id]
                )
                if damage_value <= 0:
                    raw_damage_hover[source_id, target_id] = (
                        f"<b>{source_name} → {target_name}</b><br>"
                        "No attributed damage observed"
                    )
                    continue
                raw_damage_hover[source_id, target_id] = (
                    f"<b>{source_name} → {target_name}</b><br>"
                    f"Damage: {damage_value:,.1f} hearts<br><br>"
                    "<b>Cause breakdown</b><br>"
                    f"{damage_cause_lookup.get((source_id, target_id), 'Unavailable')}"
                )

        for i, row_kit in enumerate(KIT_NAMES):
            for j, column_kit in enumerate(KIT_NAMES):
                if i >= j:
                    continue
                if np.isnan(damage_directional_share[i, j]):
                    damage_share_hover[i, j] = (
                        f"{row_kit} vs {column_kit}<br>"
                        "No attributed damage observed in either direction"
                    )
                    continue
                damage_share_hover[i, j] = (
                    f"<b>{row_kit} vs {column_kit}</b><br>"
                    f"{row_kit} damage: "
                    f"{damage_matchup_matrix.iloc[i, j]:,.1f} hearts<br>"
                    f"{column_kit} damage: "
                    f"{damage_matchup_matrix.iloc[j, i]:,.1f} hearts<br>"
                    f"{row_kit} directional damage share: "
                    f"{damage_directional_share[i, j]:.1%}<br>"
                    f"Pair damage observed: "
                    f"{damage_pair_totals[i, j]:,.1f} hearts<br><br>"
                    f"<b>{row_kit} → {column_kit} causes</b><br>"
                    f"{damage_cause_lookup.get((i, j), 'No attributed damage')}"
                    "<br><br>"
                    f"<b>{column_kit} → {row_kit} causes</b><br>"
                    f"{damage_cause_lookup.get((j, i), 'No attributed damage')}"
                )

        fig.add_trace(
            go.Heatmap(
                z=damage_share_display,
                x=KIT_ORDER,
                y=KIT_ORDER,
                zmin=0,
                zmax=1,
                zmid=0.5,
                colorscale=[
                    [0, "#D08B37"],
                    [0.5, "#F4F1EA"],
                    [1, "#2A7F7A"],
                ],
                customdata=damage_share_hover,
                hovertemplate="%{customdata}<extra></extra>",
                hoverongaps=False,
                colorbar=dict(
                    title="Row kit share",
                    tickformat=".0%",
                    tickvals=[0, 0.5, 1],
                ),
                visible=False,
            )
        )
        fig.add_trace(
            go.Heatmap(
                z=damage_matchup_matrix.values,
                x=KIT_ORDER,
                y=KIT_ORDER,
                customdata=raw_damage_hover,
                hovertemplate="%{customdata}<extra></extra>",
                colorbar=dict(title="Damage (hearts)"),
                visible=False,
            )
        )

    def trace_visibility(trace_index: int) -> list[bool]:
        return [
            index == trace_index for index in range(len(fig.data))
        ]

    buttons = [
        {
            "label": "Kill share",
            "method": "update",
            "args": [
                {"visible": trace_visibility(0)},
                {
                    "title": {
                        "text": (
                            "Which kit leads each observed head-to-head "
                            "kill exchange?"
                        )
                    },
                    "xaxis": {"title": {"text": "Other kit"}},
                    "yaxis": {"title": {"text": "Row kit"}},
                },
            ],
        },
        {
            "label": "Raw kills",
            "method": "update",
            "args": [
                {"visible": trace_visibility(1)},
                {
                    "title": {
                        "text": (
                            "How many attributed kills did each kit record "
                            "against every other kit?"
                        )
                    },
                    "xaxis": {"title": {"text": "Victim kit"}},
                    "yaxis": {"title": {"text": "Killer kit"}},
                },
            ],
        },
    ]
    if has_damage:
        buttons.extend(
            [
                {
                    "label": "Damage share",
                    "method": "update",
                    "args": [
                        {"visible": trace_visibility(2)},
                        {
                            "title": {
                                "text": (
                                    "Which kit leads each observed "
                                    "head-to-head damage exchange?"
                                )
                            },
                            "xaxis": {
                                "title": {"text": "Other kit"}
                            },
                            "yaxis": {
                                "title": {"text": "Row kit"}
                            },
                        },
                    ],
                },
                {
                    "label": "Raw damage",
                    "method": "update",
                    "args": [
                        {"visible": trace_visibility(3)},
                        {
                            "title": {
                                "text": (
                                    "How much attributed damage did each kit "
                                    "deal to every other kit?"
                                )
                            },
                            "xaxis": {
                                "title": {"text": "Target kit"}
                            },
                            "yaxis": {
                                "title": {"text": "Source kit"}
                            },
                        },
                    ],
                },
            ]
        )

    fig.update_layout(
        title=(
            "Which kit leads each observed head-to-head kill exchange?"
        ),
        xaxis_title="Other kit",
        yaxis_title="Row kit",
        margin=dict(l=70, r=40, t=125, b=70),
        updatemenus=[
            {
                "type": "buttons",
                "direction": "right",
                "x": 0.5,
                "xanchor": "center",
                "y": 1.16,
                "yanchor": "top",
                "showactive": True,
                "buttons": buttons,
            }
        ],
    )
    return fig


def kills_vs_ability_uses_figure(combined_totals: pd.DataFrame) -> go.Figure:
    """Compare kills with ability volume and cooldown-adjusted use."""

    plot_data = combined_totals.copy()
    plot_data["ability_effect_per_success_text"] = (
        _ability_effect_per_success_text(plot_data)
    )
    return _quadrant_modes_figure(
        plot_data,
        customdata_cols=(
            "ability_use",
            "kills",
            "total_hours",
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
                    "Kills: %{y:,.0f}<br>Time played: "
                    "%{customdata[2]:,.2f} h<br>Completed lives: "
                    "%{customdata[3]:,.0f}<br>Cooldown: "
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
                    "%{customdata[1]:,.0f}<br>Time played: "
                    "%{customdata[2]:,.2f} h<extra></extra>"
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
                    "activation: %{customdata[6]:.1%}<br>Effect metric: "
                    "%{customdata[9]}<br>Effectiveness: "
                    "%{customdata[12]}"
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
                    "%{customdata[3]:,.0f}<br>Cooldown: "
                    "%{customdata[4]:.1f} s<br>Cooldown-normalized rate: "
                    "%{customdata[6]:.1%}<extra></extra>"
                ),
            ),
        ),
    )


def report_summary_figure(report: ReportData) -> go.Figure:
    """Render an aligned, unit-aware profile of every kit."""

    plot_data = (
        report.summary.sort_values("kills", ascending=True)
        .reset_index(drop=True)
        .copy()
    )
    kit_names = plot_data["kit_name"].tolist()
    kit_colors = plot_data["kit_name"].map(KIT_COLORS).tolist()
    dark_outline = "#333333"

    fig = make_subplots(
        rows=1,
        cols=4,
        shared_yaxes=True,
        horizontal_spacing=0.055,
        column_widths=[0.22, 0.22, 0.30, 0.26],
        subplot_titles=(
            "Kill volume",
            "Ability use intensity",
            "Player reach",
            "Kill concentration",
        ),
    )

    kill_hover = np.column_stack(
        [
            plot_data["players_with_kills"],
            plot_data["kills_per_hour"],
            plot_data["kills_per_completed_life"],
            plot_data["total_hours"],
            plot_data["completed_lives"],
            plot_data["deaths"],
            plot_data["deaths_per_hour"],
            plot_data["kill_death_ratio"],
            plot_data["non_player_death_share"],
        ]
    )
    fig.add_trace(
        go.Bar(
            x=plot_data["kills"],
            y=kit_names,
            orientation="h",
            width=0.48,
            marker=dict(
                color=kit_colors,
                line=dict(color=dark_outline, width=1),
            ),
            opacity=0.18,
            hoverinfo="skip",
            showlegend=False,
        ),
        row=1,
        col=1,
    )
    fig.add_trace(
        go.Scatter(
            x=plot_data["kills"],
            y=kit_names,
            mode="markers",
            marker=dict(
                size=11,
                color=kit_colors,
                line=dict(color=dark_outline, width=1.25),
            ),
            customdata=kill_hover,
            hovertemplate=(
                "<b>%{y}</b><br>"
                "Total kills: %{x:,}<br>"
                "Kills per hour: %{customdata[1]:.2f}<br>"
                "Kills per completed life: %{customdata[2]:.2f}<br>"
                "Time played: %{customdata[3]:,.2f} h<br>"
                "Completed lives: %{customdata[4]:,.0f}<br>"
                "Deaths experienced: %{customdata[5]:,.0f}<br>"
                "Deaths per hour: %{customdata[6]:.2f}<br>"
                "Kills per death: %{customdata[7]:.2f}<br>"
                "Non-player death share: %{customdata[8]:.1%}<br>"
                "Players with ≥1 kill: %{customdata[0]:.0f}"
                "<extra></extra>"
            ),
            showlegend=False,
        ),
        row=1,
        col=1,
    )

    ability_success_text = [
        (
            f"{rate:.1%} ({successful:,.0f} successes)"
            if pd.notna(rate)
            else "Not logged"
        )
        for rate, successful in zip(
            plot_data["ability_success_rate"],
            plot_data["successful_uses"],
        )
    ]
    ability_effect_text = _ability_effect_per_success_text(plot_data)
    ability_hover = np.column_stack(
        [
            plot_data["players_using_ability"],
            plot_data["ability_use"],
            plot_data["ability_uses_per_hour"],
            plot_data["ability_uses_per_completed_life"],
            plot_data["ability_cooldown_seconds"],
            plot_data["theoretical_ability_uses_per_hour"],
            plot_data["median_player_cooldown_normalized_use_rate"],
            plot_data["total_hours"],
            plot_data["completed_lives"],
            ability_success_text,
            ability_effect_text,
        ]
    )
    fig.add_trace(
        go.Bar(
            x=plot_data["cooldown_normalized_use_rate"],
            y=kit_names,
            orientation="h",
            width=0.48,
            marker=dict(
                color=kit_colors,
                line=dict(color=dark_outline, width=1),
            ),
            opacity=0.18,
            hoverinfo="skip",
            showlegend=False,
        ),
        row=1,
        col=2,
    )
    fig.add_trace(
        go.Scatter(
            x=plot_data["cooldown_normalized_use_rate"],
            y=kit_names,
            mode="markers",
            marker=dict(
                size=11,
                color=kit_colors,
                line=dict(color=dark_outline, width=1.25),
            ),
            customdata=ability_hover,
            hovertemplate=(
                "<b>%{y}</b><br>"
                "Cooldown-normalized rate: %{x:.1%}<br>"
                "Median player rate: %{customdata[6]:.1%}<br>"
                "Cooldown: %{customdata[4]:.1f} s<br>"
                "Observed uses per hour: %{customdata[2]:.2f}<br>"
                "Cooldown-only maximum: %{customdata[5]:.2f} uses / h<br>"
                "Uses per completed life: %{customdata[3]:.2f}<br>"
                "Total uses: %{customdata[1]:,.0f}<br>"
                "Successful-use rate: %{customdata[9]}<br>"
                "Effectiveness: %{customdata[10]}<br>"
                "Time played: %{customdata[7]:,.2f} h<br>"
                "Completed lives: %{customdata[8]:,.0f}<br>"
                "Players using ability: %{customdata[0]:.0f}"
                "<extra></extra>"
            ),
            showlegend=False,
        ),
        row=1,
        col=2,
    )

    reach_line_x: list[float | None] = []
    reach_line_y: list[str | None] = []
    for kit_name, played_reach, kill_reach in zip(
        kit_names,
        plot_data["played"],
        plot_data["made_kill"],
    ):
        reach_line_x.extend([played_reach, kill_reach, None])
        reach_line_y.extend([kit_name, kit_name, None])

    fig.add_trace(
        go.Scatter(
            x=reach_line_x,
            y=reach_line_y,
            mode="lines",
            line=dict(color="#A1A1AA", width=2),
            hoverinfo="skip",
            showlegend=False,
        ),
        row=1,
        col=3,
    )
    played_reach_hover = np.column_stack(
        [
            plot_data["played_count"],
            np.full(len(plot_data), report.n_players),
            plot_data["total_hours"],
        ]
    )
    fig.add_trace(
        go.Scatter(
            x=plot_data["played"],
            y=kit_names,
            mode="markers",
            name="Played kit",
            marker=dict(
                size=11,
                color=kit_colors,
                symbol="circle",
                line=dict(color=dark_outline, width=1.25),
            ),
            customdata=played_reach_hover,
            hovertemplate=(
                "<b>%{y}</b><br>Played kit: %{x:.1%}<br>"
                "Players: %{customdata[0]:.0f} / %{customdata[1]:.0f}<br>"
                "Time played: %{customdata[2]:,.2f} h"
                "<extra></extra>"
            ),
            showlegend=True,
        ),
        row=1,
        col=3,
    )
    ability_reach_hover = np.column_stack(
        [
            plot_data["players_using_ability"],
            np.full(len(plot_data), report.n_players),
        ]
    )
    fig.add_trace(
        go.Scatter(
            x=plot_data["used_ability"],
            y=kit_names,
            mode="markers",
            name="Used ability",
            marker=dict(
                size=11,
                color=kit_colors,
                symbol="circle-open",
                line=dict(width=1.75),
            ),
            customdata=ability_reach_hover,
            hovertemplate=(
                "<b>%{y}</b><br>"
                "Used ability: %{x:.1%}<br>"
                "Players: %{customdata[0]:.0f} / %{customdata[1]:.0f}"
                "<extra></extra>"
            ),
            showlegend=True,
        ),
        row=1,
        col=3,
    )
    kill_reach_hover = np.column_stack(
        [
            plot_data["players_with_kills"],
            np.full(len(plot_data), report.n_players),
        ]
    )
    fig.add_trace(
        go.Scatter(
            x=plot_data["made_kill"],
            y=kit_names,
            mode="markers",
            name="Made a kill",
            marker=dict(
                size=12,
                color=kit_colors,
                symbol="diamond-open",
                line=dict(width=2),
            ),
            customdata=kill_reach_hover,
            hovertemplate=(
                "<b>%{y}</b><br>"
                "Made a kill: %{x:.1%}<br>"
                "Players: %{customdata[0]:.0f} / %{customdata[1]:.0f}"
                "<extra></extra>"
            ),
            showlegend=True,
        ),
        row=1,
        col=3,
    )

    concentration_values = plot_data["top_player_share"].dropna()
    concentration_range = (
        _padded_axis_range(
            concentration_values,
            padding_fraction=0.12,
            minimum_padding=0.025,
            upper_bound=1,
        )
        if not concentration_values.empty
        else [0, 1]
    )
    concentration_hover = np.column_stack(
        [plot_data["players_with_kills"]]
    )
    fig.add_trace(
        go.Scatter(
            x=plot_data["top_player_share"],
            y=kit_names,
            mode="markers",
            marker=dict(
                size=11,
                color=kit_colors,
                line=dict(color=dark_outline, width=1.25),
            ),
            customdata=concentration_hover,
            hovertemplate=(
                "<b>%{y}</b><br>"
                "Top-player kill share: %{x:.1%}<br>"
                "Players with ≥1 kill: %{customdata[0]:.0f}"
                "<extra></extra>"
            ),
            showlegend=False,
        ),
        row=1,
        col=4,
    )

    ability_intensity_values = plot_data[
        "cooldown_normalized_use_rate"
    ].dropna()
    median_specs = (
        (1, plot_data["kills"]),
        (2, ability_intensity_values),
        (4, concentration_values),
    )
    for column, values in median_specs:
        if values.empty:
            continue
        fig.add_vline(
            x=float(values.median()),
            line=dict(color="#8C8C8C", width=1, dash="dot"),
            opacity=0.8,
            row=1,
            col=column,
        )
    played_values = plot_data["played"].dropna()
    if not played_values.empty:
        fig.add_vline(
            x=float(played_values.median()),
            line=dict(color="#777777", width=1, dash="dot"),
            opacity=0.8,
            row=1,
            col=3,
        )
    kill_reach_values = plot_data["made_kill"].dropna()
    if not kill_reach_values.empty:
        fig.add_vline(
            x=float(kill_reach_values.median()),
            line=dict(color="#A1A1AA", width=1, dash="dash"),
            opacity=0.8,
            row=1,
            col=3,
        )

    fig.update_xaxes(title_text="Kills", rangemode="tozero", row=1, col=1)
    fig.update_xaxes(
        title_text="Cooldown-normalized use rate",
        tickformat=".0%",
        rangemode="tozero",
        row=1,
        col=2,
    )
    fig.update_xaxes(
        title_text="Share of observed players",
        tickformat=".0%",
        range=[0, 1],
        row=1,
        col=3,
    )
    fig.update_xaxes(
        title_text="Top-player share",
        tickformat=".0%",
        range=concentration_range,
        row=1,
        col=4,
    )
    fig.update_yaxes(
        categoryorder="array",
        categoryarray=kit_names,
        showgrid=False,
    )
    for column in (2, 3, 4):
        fig.update_yaxes(showticklabels=False, row=1, col=column)

    fig.update_layout(
        title="How do kits compare across the report's main balance signals?",
        height=max(540, 34 * len(plot_data) + 175),
        barmode="overlay",
        hovermode="closest",
        margin=dict(l=105, r=35, t=95, b=100),
        legend=dict(
            title="Reach signals",
            orientation="h",
            x=0.50,
            xanchor="center",
            y=-0.16,
            yanchor="top",
        ),
    )
    return fig

"""Kill, damage, and cause-profile figures."""

from __future__ import annotations

from typing import Sequence, TypedDict, cast

import numpy as np
import pandas as pd
import plotly.graph_objects as go

from .core import KIT_ORDER, ReportData
from .plot_components import (
    AggregateMetricView,
    HorizontalReferenceLine,
    KIT_COLORS,
    STANDARD_FIGURE_HEIGHT,
    _elo_name,
    _format_hours,
    _trace_count,
    player_contribution_figure,
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


class _CauseMode(TypedDict):
    """One complete state of the switchable cause-profile figure."""

    button_label: str
    data: pd.DataFrame
    value_col: str
    order: Sequence[str]
    title: str
    xaxis_title: str
    yaxis_title: str
    tickformat: str
    range: list[int] | None
    custom_cols: list[str]
    hovertemplate: str


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


def _stacked_cause_modes_figure(
    *,
    causes: pd.DataFrame,
    modes: Sequence[_CauseMode],
    cause_colors: dict[int, str],
    legend_title: str,
) -> go.Figure:
    """Render switchable stacked cause profiles in one single-axis figure."""

    cause_rows = [
        (int(cast(float, cause_id)), str(cause_name))
        for cause_id, cause_name in causes.sort_values("cause_id")[
            ["cause_id", "cause_name"]
        ].itertuples(index=False, name=None)
    ]
    fig = go.Figure()
    traces_per_mode = len(cause_rows)
    for mode_index, mode in enumerate(modes):
        frame = mode["data"]
        order = mode["order"]
        for cause_id, cause_name in cause_rows:
            cause_data = (
                frame.loc[frame["cause_id"] == cause_id]
                .set_index("kit_name")
                .reindex(list(order))
            )
            fig.add_trace(
                go.Bar(
                    x=order,
                    y=cause_data[mode["value_col"]],
                    name=cause_name,
                    legendgroup=cause_name,
                    legendrank=cause_id,
                    meta={
                        "role": "cause",
                        "causeId": str(cause_id),
                        "highlightGroup": "cause",
                        "highlightValue": str(cause_id),
                    },
                    marker=dict(
                        color=cause_colors[cause_id],
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
            for trace_index in range(_trace_count(fig))
        ]

    first_mode = modes[0]
    fig.update_layout(
        title=first_mode["title"],
        height=STANDARD_FIGURE_HEIGHT,
        barmode="stack",
        clickmode="event",
        hovermode="closest",
        legend=dict(
            title=dict(text=legend_title),
            orientation="h",
            x=0.5,
            xanchor="center",
            y=-0.18,
            yanchor="top",
            entrywidth=115,
            entrywidthmode="pixels",
            itemsizing="constant",
        ),
        margin=dict(l=70, r=40, t=160, b=135),
        updatemenus=[
            {
                "type": "buttons",
                "direction": "right",
                "x": 0.5,
                "xanchor": "center",
                "y": 1.15,
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
    totals = report.kit_metrics.copy()
    totals["active_time_text"] = totals["total_hours"].map(_format_hours)
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
        totals=totals,
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
            "%{customdata[1]:,.0f}<br>"
            "Rated encounters: %{customdata[2]:,.0f}<extra></extra>"
            if elo_available
            else None
        ),
        aggregate_customdata_cols=(
            "player_caused_deaths",
            "non_player_deaths",
            "active_time_text",
            "players_with_kill_rate_per_hour",
            "players_with_kill_rate_per_life",
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
                    "Player-caused deaths: %{customdata[6]:,.0f}<br>"
                    "Non-player deaths: %{customdata[7]:,.0f}"
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
                    "<b>%{x}</b><br>Kit aggregate rate: %{y:.2f} kills / h<br>"
                    "Median individual player rate: "
                    "%{customdata[4]:.2f} kills / h "
                    "(players: %{customdata[9]:,.0f})<br>"
                    "Total kills: %{customdata[0]:,.0f}<br>"
                    "Active time: %{customdata[8]}"
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
                    "<b>%{x}</b><br>Kit aggregate rate: "
                    "%{y:.2f} kills / completed life<br>"
                    "Median individual player rate: "
                    "%{customdata[5]:.2f} kills / completed life "
                    "(players: %{customdata[10]:,.0f})<br>"
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
                    "Player-caused deaths: %{customdata[6]:,.0f}<br>"
                    "Non-player deaths: %{customdata[7]:,.0f}"
                    "<extra></extra>"
                ),
            ),
        ),
    )


def damage_figure(report: ReportData) -> go.Figure:
    """Compare damage output, intake, exchange, and source players."""

    elo_available = not report.elo_metadata.empty
    elo_name = _elo_name(report)
    totals = report.summary.copy()
    totals["active_time_text"] = totals["total_hours"].map(_format_hours)
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
        totals=totals,
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
            "Damage dealt: %{y:,.0f} hearts<br>"
            f"{elo_name}: %{{customdata[1]:,.0f}}<br>"
            "Rated encounters: %{customdata[2]:,.0f}<extra></extra>"
            if elo_available
            else None
        ),
        aggregate_customdata_cols=(
            "player_damage_received",
            "non_player_damage_received",
            "player_damage_received_per_hour",
            "non_player_damage_received_per_hour",
            "damage_dealt_per_kill",
            "kills",
            "active_time_text",
            "players_with_damage_rate_per_hour",
            "damage_received",
        ),
        player_value_format=",.0f",
        metric_views=(
            AggregateMetricView(
                button_label="Total dealt",
                value_col="damage_dealt",
                title="Which kits dealt the most attributed player damage?",
                yaxis_title="Damage dealt (hearts)",
                tickformat=",.0f",
                hovertemplate=(
                    "<b>%{x}</b><br>Damage dealt: %{y:,.0f} hearts<br>"
                    "Attributed kills: %{customdata[11]:,.0f}<br>"
                    "Damage per attributed kill: "
                    "%{customdata[10]:,.0f} hearts"
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
                    "<b>%{x}</b><br>Kit aggregate rate: "
                    "%{y:,.0f} hearts / h<br>"
                    "Median individual player rate: "
                    "%{customdata[4]:,.0f} hearts / h "
                    "(players: %{customdata[13]:,.0f})<br>"
                    "Total damage dealt: %{customdata[0]:,.0f} hearts<br>"
                    "Active time: %{customdata[12]}"
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
                    "<b>%{x}</b><br>All damage received: "
                    "%{y:,.0f} hearts / h<br>Player damage: "
                    "%{customdata[8]:,.0f} hearts / h<br>"
                    "Non-player damage: %{customdata[9]:,.0f} hearts / h<br>"
                    "Total damage received: %{customdata[14]:,.0f} hearts<br>"
                    "Active time: %{customdata[12]}<extra></extra>"
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
                    "Player damage dealt: %{customdata[0]:,.0f} hearts<br>"
                    "Player damage received: %{customdata[6]:,.0f} hearts"
                    "<extra></extra>"
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
            height=STANDARD_FIGURE_HEIGHT,
            xaxis_title="Kit",
            yaxis_title="Share",
        )
        return fig

    cause_colors = _cause_color_map(report)
    outgoing = report.outgoing_kills_by_cause.copy()
    incoming = report.incoming_deaths_by_cause.copy()
    incoming["active_time_text"] = incoming["total_hours"].map(
        _format_hours
    )
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

    modes: tuple[_CauseMode, ...] = (
        {
            "button_label": "Outgoing share",
            "data": outgoing,
            "value_col": "cause_share_of_kit_kills",
            "order": outgoing_order,
            "title": "How does each kit secure its attributed player kills?",
            "xaxis_title": "Attacking kit",
            "yaxis_title": "Share of attributed kills",
            "tickformat": ".0%",
            "range": [0, 1],
            "custom_cols": [
                "kills",
                "kit_total_kills",
            ],
            "hovertemplate": (
                "<b>%{x}</b><br>%{fullData.name}<br>"
                "Share of kit kills: %{y:.1%}<br>"
                "Kills from cause: %{customdata[0]:,.0f}<br>"
                "All attributed kit kills: %{customdata[1]:,.0f}"
                "<extra></extra>"
            ),
        },
        {
            "button_label": "Incoming deaths / hour",
            "data": incoming,
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
                "active_time_text",
            ],
            "hovertemplate": (
                "<b>%{x}</b><br>%{fullData.name}<br>"
                "Deaths per hour from cause: %{y:.2f}<br>"
                "Deaths from cause: %{customdata[0]:,.0f}<br>"
                "Share of kit deaths: %{customdata[1]:.1%}<br>"
                "Active time: %{customdata[2]}"
                "<extra></extra>"
            ),
        },
        {
            "button_label": "Incoming share",
            "data": incoming,
            "value_col": "cause_share_of_kit_deaths",
            "order": incoming_share_order,
            "title": "What accounts for each kit's observed deaths?",
            "xaxis_title": "Victim kit",
            "yaxis_title": "Share of all deaths while using kit",
            "tickformat": ".0%",
            "range": [0, 1],
            "custom_cols": [
                "deaths",
                "kit_total_deaths",
            ],
            "hovertemplate": (
                "<b>%{x}</b><br>%{fullData.name}<br>"
                "Share of kit deaths: %{y:.1%}<br>"
                "Deaths from cause: %{customdata[0]:,.0f}<br>"
                "All kit deaths: %{customdata[1]:,.0f}"
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
            height=STANDARD_FIGURE_HEIGHT,
            xaxis_title="Kit",
            yaxis_title="Damage",
        )
        return fig

    cause_colors = _cause_color_map(report)
    outgoing = report.outgoing_damage_by_cause.copy()
    incoming = report.incoming_damage_by_cause.copy()
    outgoing["active_time_text"] = outgoing["total_hours"].map(
        _format_hours
    )
    incoming["active_time_text"] = incoming["total_hours"].map(
        _format_hours
    )
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
        "kit_total_damage_dealt",
        "active_time_text",
    ]
    incoming_custom_cols = [
        "damage_received",
        "cause_share_of_kit_damage_received",
        "kit_total_damage_received",
        "active_time_text",
    ]
    modes: tuple[_CauseMode, ...] = (
        {
            "button_label": "Dealt / hour",
            "data": outgoing,
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
                "Cause damage per hour: %{y:,.0f} hearts<br>"
                "Cause damage: %{customdata[0]:,.0f} hearts<br>"
                "Share of kit damage: %{customdata[1]:.1%}<br>"
                "Active time: %{customdata[3]}"
                "<extra></extra>"
            ),
        },
        {
            "button_label": "Dealt share",
            "data": outgoing,
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
                "Cause damage: %{customdata[0]:,.0f} hearts<br>"
                "All attributed kit damage: "
                "%{customdata[2]:,.0f} hearts"
                "<extra></extra>"
            ),
        },
        {
            "button_label": "Received / hour",
            "data": incoming,
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
                "Cause damage per hour: %{y:,.0f} hearts<br>"
                "Cause damage received: %{customdata[0]:,.0f} hearts<br>"
                "Share of received damage: %{customdata[1]:.1%}<br>"
                "Active time: %{customdata[3]}<extra></extra>"
            ),
        },
        {
            "button_label": "Received share",
            "data": incoming,
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
                "Cause damage received: %{customdata[0]:,.0f} hearts<br>"
                "All damage received: %{customdata[2]:,.0f} hearts"
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

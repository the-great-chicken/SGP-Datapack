"""Reusable Plotly visualizations for the SGP kit report.

Loading, validation, and metric derivation live in :mod:`sgp_data`.  This
module is intentionally limited to visual presentation and repeated notebook
display interactions.
"""

from __future__ import annotations

import numpy as np
import pandas as pd
import plotly.graph_objects as go

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
    STANDARD_FIGURE_HEIGHT,
    _padded_axis_range,
    _quadrant_modes_figure,
    _quadrant_scatter_figure,
    concentration_figure,
    player_contribution_figure,
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
            formatted_effect = (
                f"{effect_value:,.0f}"
                if effect_unit == "hearts"
                else f"{effect_value:,.2f}"
            )
            values.append(
                f"{metric_name}: {formatted_effect} "
                f"{effect_unit} / successful use"
            )
    return pd.Series(values, index=data.index, dtype=object)


def _format_hours(value: object) -> str:
    """Format fractional hours as a duration people can read at a glance."""

    numeric = pd.to_numeric(pd.Series([value]), errors="coerce").iloc[0]
    if pd.isna(numeric):
        return "Not available"
    total_minutes = max(0, int(round(float(numeric) * 60)))
    hours, minutes = divmod(total_minutes, 60)
    if hours:
        return f"{hours:,} h {minutes:02d} min"
    return f"{minutes:,} min"


def _format_minutes(value: object) -> str:
    """Format fractional minutes without displaying decimal time."""

    numeric = pd.to_numeric(pd.Series([value]), errors="coerce").iloc[0]
    if pd.isna(numeric):
        return "Not available"
    total_seconds = max(0, int(round(float(numeric) * 60)))
    minutes, seconds = divmod(total_seconds, 60)
    if minutes:
        return f"{minutes:,} min {seconds:02d} sec"
    return f"{seconds} sec"


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

    modes = (
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
    modes = (
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
    plot_data["active_time_text"] = plot_data["total_hours"].map(
        _format_hours
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
                "active_time_text": "Active time",
                "kills": "Attributed kills",
                "kit_name": "Kit",
            },
            hover_data={
                "time_share": ":.1%",
                "kills_per_hour": ":.2f",
                "active_time_text": True,
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
        "kills",
        "active_time_text",
        "playtime_weighted_player_elo",
        "overall_playtime_weighted_player_elo",
        "player_elo_difference_from_overall",
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
                    "Attributed kills: %{customdata[2]:,.0f}<br>"
                    "Active time: %{customdata[3]}<extra></extra>"
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
                    f"{elo_name}: %{{x:,.0f}}<br>Difference from overall: "
                    "%{customdata[6]:+,.0f}<br>Overall playtime-weighted "
                    f"{elo_name}: %{{customdata[5]:,.0f}}<br>"
                    "Median player experience: %{customdata[7]:,.0f} "
                    "rated encounters<br>Kills per hour: %{y:.2f}<br>"
                    "Attributed kills: %{customdata[2]:,.0f}<br>"
                    "Active time: %{customdata[3]}<extra></extra>"
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
    reach_order = (
        plot_data.sort_values(
            ["played", "used_ability", "made_kill", "kit_name"],
            ascending=[True, True, True, True],
            na_position="first",
        )["kit_name"].tolist()
    )

    fig = go.Figure()

    reach_line_x: list[float | None] = []
    reach_line_y: list[str | None] = []
    for row in plot_data.itertuples(index=False):
        reach_line_x.extend([row.played, row.made_kill, None])
        reach_line_y.extend([row.kit_name, row.kit_name, None])

    fig.add_trace(
        go.Scatter(
            x=reach_line_x,
            y=reach_line_y,
            mode="lines",
            line=dict(color="#A1A1AA", width=2),
            hoverinfo="skip",
            showlegend=False,
        )
    )
    fig.add_trace(
        go.Scatter(
            x=plot_data["played"],
            y=plot_data["kit_name"],
            mode="markers",
            name="Tried kit",
            marker=dict(
                size=11,
                color=kit_colors,
                symbol="circle",
                line=dict(color="#333333", width=1.2),
            ),
            customdata=np.column_stack(
                [plot_data["played_count"], denominator]
            ),
            hovertemplate=(
                "<b>%{y}</b><br>Tried the kit: %{x:.1%}<br>"
                "Players: %{customdata[0]:.0f} / %{customdata[1]:.0f}<br>"
                "<extra></extra>"
            ),
        )
    )
    fig.add_trace(
        go.Scatter(
            x=plot_data["used_ability"],
            y=plot_data["kit_name"],
            mode="markers",
            name="Used ability",
            marker=dict(
                size=11,
                color=kit_colors,
                symbol="circle-open",
                line=dict(color="#333333", width=1.8),
            ),
            customdata=np.column_stack(
                [plot_data["used_ability_count"], denominator]
            ),
            hovertemplate=(
                "<b>%{y}</b><br>Used the ability: %{x:.1%}<br>"
                "Players: %{customdata[0]:.0f} / %{customdata[1]:.0f}"
                "<extra></extra>"
            ),
        )
    )
    fig.add_trace(
        go.Scatter(
            x=plot_data["made_kill"],
            y=plot_data["kit_name"],
            mode="markers",
            name="Made a kill",
            marker=dict(
                size=12,
                color=kit_colors,
                symbol="diamond-open",
                line=dict(color="#333333", width=2),
            ),
            customdata=np.column_stack(
                [plot_data["made_kill_count"], denominator]
            ),
            hovertemplate=(
                "<b>%{y}</b><br>Made an attributed player kill: "
                "%{x:.1%}<br>Players: %{customdata[0]:.0f} / "
                "%{customdata[1]:.0f}<extra></extra>"
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
                    [_format_hours(row["total_hours"])],
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
            x=plot_data["hours_per_completed_life"] * 60,
            y=plot_data["kit_name"],
            orientation="h",
            name="Average life duration",
            marker={
                "color": kit_colors,
                "line": {"color": "#333333", "width": 1},
            },
            customdata=np.column_stack(
                [
                    (plot_data["hours_per_completed_life"] * 60).map(
                        _format_minutes
                    ),
                    plot_data["completed_lives"],
                    plot_data["players_with_completed_life"],
                ]
            ),
            showlegend=False,
            visible=False,
            hovertemplate=(
                "<b>%{y}</b><br>Average completed-life duration: "
                "%{customdata[0]}<br>"
                "Completed lives: %{customdata[1]:,.0f}<br>"
                "Players with a completed life: %{customdata[2]:,.0f}"
                "<extra></extra>"
            ),
        )
    )

    exposure_trace_count = len(exposure_order)
    reach_trace_count = 4
    life_trace_index = reach_trace_count + exposure_trace_count
    player_visibility = [True] * reach_trace_count + [False] * (
        exposure_trace_count + 1
    )
    exposure_visibility = [False] * reach_trace_count + [
        True
    ] * exposure_trace_count + [False]
    life_visibility = [False] * life_trace_index + [True]

    player_layout = {
        "title": {
            "text": "How broadly did each kit reach observed players?"
        },
        "barmode": "group",
        "height": STANDARD_FIGURE_HEIGHT,
        "xaxis": {
            "title": {"text": "Share of observed players"},
            "type": "linear",
            "tickformat": ".0%",
            "range": [0, 1],
            "autorange": False,
        },
        "yaxis": {
            "title": {"text": "Kit"},
            "type": "category",
            "categoryorder": "array",
            "categoryarray": reach_order,
            "range": None,
            "autorange": True,
        },
        "legend": {
            "title": {"text": "Reached by"},
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
        "height": STANDARD_FIGURE_HEIGHT,
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
        "height": STANDARD_FIGURE_HEIGHT,
        "xaxis": {
            "title": {"text": "Minutes per completed life"},
            "type": "linear",
            "range": None,
            "autorange": True,
            "tickformat": ".0f",
            "rangemode": "tozero",
        },
        "yaxis": {
            "title": {"text": "Kit"},
            "type": "category",
            "categoryorder": "array",
            "categoryarray": (
                plot_data.sort_values(
                    "hours_per_completed_life",
                    ascending=True,
                    na_position="first",
                )["kit_name"].tolist()
            ),
            "range": None,
            "autorange": True,
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
        margin=dict(l=105, r=35, t=125, b=135),
        hovermode="closest",
        updatemenus=[
            {
                "type": "buttons",
                "direction": "right",
                "x": 0.5,
                "xanchor": "center",
                "y": 1.13,
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
            "top_player_share": "Top player's share of kit kills",
            "players_with_kills": "Players with kills",
            "top_3_share": "Top 3 players' share",
            "kit_name": "Kit",
        },
        hover_data={
            "kills": True,
            "kills_per_hour": ":.2f",
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
        fig.update_layout(title=first_view["title"], height=650)
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
        for row in plot_data.itertuples(index=False):
            customdata_values = [
                getattr(row, f"{prefix}_id"),
                getattr(row, f"{prefix}_kills"),
                _format_hours(getattr(row, f"{prefix}_hours")),
                getattr(row, f"{prefix}_kill_share_minus_time_share"),
            ]
            if elo_available:
                customdata_values.extend(
                    [
                        getattr(row, f"{prefix}_rating"),
                        getattr(row, f"{prefix}_rated_encounters"),
                    ]
                )
            customdata = [customdata_values]
            selected_elo_hover = (
                f"{elo_name}: %{{customdata[4]:,.0f}}<br>"
                "Rated encounters: %{customdata[5]:,.0f}<br>"
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
                        "Kill share − playtime share: "
                        "%{customdata[3]:+.1%}<br>"
                        "Attributed kills: %{customdata[1]:,.0f}<br>"
                        "Active time: %{customdata[2]}<br>"
                        + selected_elo_hover
                        + "<extra></extra>"
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


def elo_adjusted_kill_results_figure(report: ReportData) -> go.Figure:
    """Show kit kill results relative to players' current Elo ratings."""

    elo_name = _elo_name(report)
    title = (
        "Which kits win more cross-kit kill exchanges than their players’ "
        f"current {elo_name} implies?"
    )
    fig = go.Figure()
    if report.elo_metadata.empty:
        fig.update_layout(
            title=title,
            height=STANDARD_FIGURE_HEIGHT,
            xaxis_title=(
                "Observed minus current-Elo-implied kill-exchange share"
            ),
            yaxis_title="Kit",
        )
        fig.add_annotation(
            text="Current Elo data is not available in this extraction.",
            x=0.5,
            y=0.5,
            xref="paper",
            yref="paper",
            showarrow=False,
        )
        return fig

    plot_data = report.elo_kill_results.loc[
        report.elo_kill_results["cross_kit_results"] > 0
    ].copy()
    plot_data = plot_data.replace([np.inf, -np.inf], np.nan).dropna(
        subset=["score_rate_minus_current_elo"]
    )
    if plot_data.empty:
        fig.update_layout(
            title=title,
            height=STANDARD_FIGURE_HEIGHT,
            xaxis_title=(
                "Observed minus current-Elo-implied kill-exchange share"
            ),
            yaxis_title="Kit",
        )
        fig.add_annotation(
            text="No Elo-comparable cross-kit kill results were observed.",
            x=0.5,
            y=0.5,
            xref="paper",
            yref="paper",
            showarrow=False,
        )
        return fig

    plot_data = plot_data.sort_values(
        ["score_rate_minus_current_elo", "kit_id"],
        ascending=[True, True],
    )
    order = plot_data["kit_name"].tolist()
    customdata_columns = [
        "observed_cross_kit_score_rate",
        "current_elo_implied_score_rate",
        "cross_kit_kills",
        "cross_kit_deaths",
    ]
    fig.add_trace(
        go.Bar(
            x=plot_data["score_rate_minus_current_elo"],
            y=plot_data["kit_name"],
            orientation="h",
            marker=dict(
                color=plot_data["kit_name"].map(KIT_COLORS),
                line=dict(color="#333333", width=0.7),
            ),
            customdata=plot_data[customdata_columns].to_numpy(),
            hovertemplate=(
                "<b>%{y}</b><br>Observed kill-exchange share: "
                "%{customdata[0]:.1%}<br>Share implied by current "
                f"{elo_name}: %{{customdata[1]:.1%}}<br>"
                "Difference: %{x:+.1%}<br>Cross-kit kills: "
                "%{customdata[2]:,.0f}<br>Cross-kit deaths: "
                "%{customdata[3]:,.0f}<extra></extra>"
            ),
            showlegend=False,
        )
    )
    max_difference = max(
        float(plot_data["score_rate_minus_current_elo"].abs().max()),
        0.02,
    )
    axis_limit = min(1.05, max_difference * 1.16)
    fig.add_vline(
        x=0,
        line=dict(color="#111111", width=2),
        layer="below",
    )
    fig.add_annotation(
        x=0.01,
        y=0.98,
        xref="paper",
        yref="paper",
        text=(
            "<b>Possible kit disadvantage</b><br>"
            "Players using the kit claimed a smaller share of cross-kit "
            "kills<br>than the killers’ and victims’ current ratings would "
            "suggest.<br>If this persists across many kills and deaths,<br>"
            "the kit may be holding them back."
        ),
        showarrow=False,
        xanchor="left",
        yanchor="top",
        align="left",
        font=dict(size=12, color="#555555"),
        bgcolor="rgba(255,255,255,0.78)",
    )
    fig.add_annotation(
        x=0.99,
        y=0.02,
        xref="paper",
        yref="paper",
        text=(
            "<b>Possible kit advantage</b><br>"
            "Players using the kit claimed a larger share of cross-kit "
            "kills<br>than the killers’ and victims’ current ratings would "
            "suggest.<br>If this persists across many kills and deaths,<br>"
            "the kit may be helping them outperform their rating."
        ),
        showarrow=False,
        xanchor="right",
        yanchor="bottom",
        align="right",
        font=dict(size=12, color="#555555"),
        bgcolor="rgba(255,255,255,0.78)",
    )
    fig.update_layout(
        title=title,
        height=STANDARD_FIGURE_HEIGHT,
        margin=dict(l=90, r=40, t=90, b=75),
        bargap=0.28,
        hovermode="closest",
    )
    fig.update_xaxes(
        title=(
            "Observed minus current-Elo-implied kill-exchange share "
            "(percentage points)"
        ),
        tickformat="+.0%",
        range=[-axis_limit, axis_limit],
        zeroline=False,
    )
    fig.update_yaxes(
        title="Kit",
        categoryorder="array",
        categoryarray=order,
    )
    return fig


def matchup_figure(
    matchup_matrix: pd.DataFrame,
    directional_share: np.ndarray,
    pair_totals: np.ndarray,
    matchup_kills_by_cause: pd.DataFrame,
    *,
    elo_matchup_expected_share: np.ndarray | None = None,
    elo_matchup_score_difference: np.ndarray | None = None,
    elo_matchup_pair_totals: np.ndarray | None = None,
    elo_name: str = "Kill Elo",
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

    elo_trace_index: int | None = None
    has_elo = all(
        value is not None
        for value in (
            elo_matchup_expected_share,
            elo_matchup_score_difference,
            elo_matchup_pair_totals,
        )
    )
    if has_elo:
        expected_shape = (len(KIT_NAMES), len(KIT_NAMES))
        elo_expected = np.asarray(
            elo_matchup_expected_share,
            dtype=float,
        )
        elo_difference = np.asarray(
            elo_matchup_score_difference,
            dtype=float,
        )
        elo_totals = np.asarray(elo_matchup_pair_totals, dtype=int)
        if any(
            values.shape != expected_shape
            for values in (elo_expected, elo_difference, elo_totals)
        ):
            raise ValueError(
                "Elo matchup arrays must match the kit matchup matrix shape"
            )
        has_elo = bool(
            np.isfinite(elo_difference).any() and (elo_totals > 0).any()
        )

    if has_elo:
        elo_display = elo_difference.copy()
        elo_display[np.tril_indices(len(KIT_NAMES))] = np.nan
        elo_hover = np.full_like(elo_difference, "", dtype=object)
        for i, row_kit in enumerate(KIT_NAMES):
            for j, column_kit in enumerate(KIT_NAMES):
                if i >= j:
                    continue
                result_count = int(elo_totals[i, j])
                if result_count <= 0 or not np.isfinite(
                    elo_difference[i, j]
                ):
                    elo_hover[i, j] = (
                        f"<b>{row_kit} vs {column_kit}</b><br>"
                        "No Elo-comparable cross-kit kill results"
                    )
                    continue
                observed_share = (
                    elo_expected[i, j] + elo_difference[i, j]
                )
                row_kills = int(round(observed_share * result_count))
                column_kills = result_count - row_kills
                elo_hover[i, j] = (
                    f"<b>{row_kit} vs {column_kit}</b><br>"
                    f"Observed {row_kit} kill share: "
                    f"{observed_share:.1%}<br>"
                    f"Share implied by current {elo_name}: "
                    f"{elo_expected[i, j]:.1%}<br>"
                    f"Difference: {elo_difference[i, j]:+.1%}<br>"
                    f"{row_kit} kills: {row_kills:,}<br>"
                    f"{column_kit} kills: {column_kills:,}"
                )
        finite_differences = np.abs(
            elo_difference[np.isfinite(elo_difference)]
        )
        elo_limit = max(
            float(finite_differences.max())
            if finite_differences.size
            else 0.0,
            0.02,
        )
        elo_trace_index = len(fig.data)
        fig.add_trace(
            go.Heatmap(
                z=elo_display,
                x=KIT_ORDER,
                y=KIT_ORDER,
                zmin=-elo_limit,
                zmax=elo_limit,
                zmid=0,
                colorscale=[
                    [0, "#D08B37"],
                    [0.5, "#F4F1EA"],
                    [1, "#2A7F7A"],
                ],
                customdata=elo_hover,
                hovertemplate="%{customdata}<extra></extra>",
                hoverongaps=False,
                colorbar=dict(
                    title="Observed −<br>Elo-implied",
                    tickformat="+.0%",
                ),
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
    damage_share_trace_index: int | None = None
    raw_damage_trace_index: int | None = None
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
                f"{row.cause_name}: {row.damage_received:,.0f} hearts "
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
                    f"Damage: {damage_value:,.0f} hearts<br><br>"
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
                    f"{damage_matchup_matrix.iloc[i, j]:,.0f} hearts<br>"
                    f"{column_kit} damage: "
                    f"{damage_matchup_matrix.iloc[j, i]:,.0f} hearts<br>"
                    f"{row_kit} directional damage share: "
                    f"{damage_directional_share[i, j]:.1%}<br>"
                    f"Pair damage observed: "
                    f"{damage_pair_totals[i, j]:,.0f} hearts<br><br>"
                    f"<b>{row_kit} → {column_kit} causes</b><br>"
                    f"{damage_cause_lookup.get((i, j), 'No attributed damage')}"
                    "<br><br>"
                    f"<b>{column_kit} → {row_kit} causes</b><br>"
                    f"{damage_cause_lookup.get((j, i), 'No attributed damage')}"
                )

        damage_share_trace_index = len(fig.data)
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
        raw_damage_trace_index = len(fig.data)
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
    if elo_trace_index is not None:
        buttons.append(
            {
                "label": "Kills vs Elo",
                "method": "update",
                "args": [
                    {"visible": trace_visibility(elo_trace_index)},
                    {
                        "title": {
                            "text": (
                                "Which kit wins more of each matchup than "
                                f"current {elo_name} implies?"
                            )
                        },
                        "xaxis": {"title": {"text": "Other kit"}},
                        "yaxis": {"title": {"text": "Row kit"}},
                    },
                ],
            }
        )
    if has_damage:
        if (
            damage_share_trace_index is None
            or raw_damage_trace_index is None
        ):
            raise RuntimeError("Damage traces were not initialized")
        buttons.extend(
            [
                {
                    "label": "Damage share",
                    "method": "update",
                    "args": [
                        {
                            "visible": trace_visibility(
                                damage_share_trace_index
                            )
                        },
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
                        {
                            "visible": trace_visibility(
                                raw_damage_trace_index
                            )
                        },
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
        height=STANDARD_FIGURE_HEIGHT,
        xaxis_title="Other kit",
        yaxis_title="Row kit",
        margin=dict(l=70, r=40, t=125, b=70),
        updatemenus=[
            {
                "type": "buttons",
                "direction": "right",
                "x": 0.5,
                "xanchor": "center",
                "y": 1.11,
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

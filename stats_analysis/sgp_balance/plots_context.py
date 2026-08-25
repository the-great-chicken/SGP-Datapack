"""Adoption, concentration, leading-player, and Elo-context figures."""

from __future__ import annotations

import numpy as np
import pandas as pd
import plotly.graph_objects as go

from .core import KIT_NAMES, KIT_ORDER, ReportData
from .plot_components import (
    ConcentrationView,
    KIT_COLORS,
    QuadrantMode,
    STANDARD_FIGURE_HEIGHT,
    _elo_name,
    _format_hours,
    _format_minutes,
    _padded_axis_range,
    _quadrant_modes_figure,
    _quadrant_scatter_figure,
    concentration_figure,
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

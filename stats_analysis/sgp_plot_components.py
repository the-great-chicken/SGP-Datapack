"""Reusable interactive Plotly components for the SGP report.

This module owns generic chart mechanics: buttons, visibility masks, player
highlighting, concentration composition, and median-quadrant layouts.  The
SGP-specific choice of metrics and report story remain in :mod:`sgp_report`.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Literal, Sequence

import numpy as np
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go

from sgp_data import KIT_ORDER


KIT_COLORS = {
    "tank": "#0000AA",
    "pigeon": "#555555",
    "vindicateur": "#00AA00",
    "pyromane": "#FFAA00",
    "poseidon": "#00AAAA",
    "eclaireur": "#55FFFF",
    "combattant": "#FFFFFF",
    "enderman": "#AA00AA",
    "alchimiste": "#FF55FF",
    "archer": "#55FF55",
    "roi": "#FFFF55",
    "cancer": "#AA0000",
}

MetricKind = Literal["count", "percent"]
MetricSpec = tuple[str, str, MetricKind]


@dataclass(frozen=True)
class HorizontalReferenceLine:
    """A labeled horizontal reference shown in one metric mode."""

    value: float
    label: str
    color: str
    width: float
    dash: str = "solid"


@dataclass(frozen=True)
class AggregateMetricView:
    """One aggregate mode in a total-versus-player contribution chart."""

    button_label: str
    value_col: str
    title: str
    yaxis_title: str
    hovertemplate: str
    tickformat: str
    reference_lines: tuple[HorizontalReferenceLine, ...] = ()
    yaxis_range: tuple[float, float] | None = None


@dataclass(frozen=True)
class ConcentrationView:
    """Columns and labels for one contributor-concentration mode."""

    button_label: str
    total_col: str
    top_player_col: str
    top_three_col: str
    players_col: str
    title: str
    yaxis_title: str


@dataclass(frozen=True)
class QuadrantMode:
    """Axes and annotations for one mode of a quadrant scatter."""

    button_label: str
    x_col: str
    y_col: str
    title: str
    xaxis_title: str
    yaxis_title: str
    quadrant_labels: tuple[str, str, str, str]
    hovertemplate: str
    x_tickformat: str | None = None
    y_tickformat: str | None = None


TRACE_DIM_OPACITY = 0.15
TRACE_HIGHLIGHT_POST_SCRIPT = f"""
(() => {{
    const plot = document.getElementById("{{plot_id}}");
    const dimOpacity = {TRACE_DIM_OPACITY};
    let selectedGroup = null;
    let selectedValue = null;

    plot.on("plotly_click", (event) => {{
        const point = event.points && event.points[0];
        const traceMeta = point && point.data && point.data.meta;
        const clickedGroup = traceMeta &&
            (traceMeta.highlightGroup ?? traceMeta.role);
        const clickedValue = traceMeta &&
            (
                traceMeta.highlightValue ??
                traceMeta.playerId ??
                traceMeta.causeId
            );
        if (
            !point ||
            clickedGroup == null ||
            clickedValue == null
        ) {{
            return;
        }}

        const sameSelection =
            selectedGroup === clickedGroup &&
            selectedValue === clickedValue;
        selectedGroup = sameSelection ? null : clickedGroup;
        selectedValue = sameSelection ? null : clickedValue;

        const highlightTraceIndices = plot.data
            .map((_, traceIndex) => traceIndex)
            .filter((traceIndex) => {{
                const meta = plot.data[traceIndex].meta;
                return meta &&
                    (meta.highlightGroup ?? meta.role) === clickedGroup;
            }});
        const opacities = highlightTraceIndices.map((traceIndex) => {{
            const meta = plot.data[traceIndex].meta;
            const traceValue =
                meta.highlightValue ?? meta.playerId ?? meta.causeId;
            return selectedValue === null || traceValue === selectedValue
                ? 1
                : dimOpacity;
        }});

        Plotly.restyle(
            plot,
            {{ opacity: opacities }},
            highlightTraceIndices
        );
    }});
}})();
"""
# Backward-compatible public name for notebooks or callers that imported it.
PLAYER_DIM_OPACITY = TRACE_DIM_OPACITY
PLAYER_HIGHLIGHT_POST_SCRIPT = TRACE_HIGHLIGHT_POST_SCRIPT


def player_contribution_figure(
    *,
    all_kits: pd.DataFrame,
    totals: pd.DataFrame,
    by_player: pd.DataFrame,
    player_col: str,
    player_value_col: str,
    median_per_hour_col: str,
    median_per_life_col: str,
    metric_views: Sequence[AggregateMetricView],
    player_title: str | None = None,
    aggregate_customdata_cols: Sequence[str] = (),
    player_value_format: str = ",.0f",
) -> go.Figure:
    """Build aggregate-rate modes plus the player-contribution interaction.

    In the player-stacked view, clicking any segment focuses that player's
    trace across every kit. Clicking the focused player again restores all
    player colors.
    """

    if not metric_views:
        raise ValueError("metric_views must contain at least one mode")

    fig = go.Figure()
    aggregate_customdata_columns = [
        totals[player_value_col],
        totals["total_hours"],
        totals["completed_lives"],
        totals["players_with_time"],
        totals[median_per_hour_col],
        totals[median_per_life_col],
    ]
    aggregate_customdata_columns.extend(
        totals[column] for column in aggregate_customdata_cols
    )
    aggregate_customdata = np.column_stack(aggregate_customdata_columns)
    for mode_index, mode in enumerate(metric_views):
        fig.add_trace(
            go.Bar(
                x=totals["kit_name"],
                y=totals[mode.value_col],
                marker={
                    "color": totals["kit_name"].map(KIT_COLORS),
                    "line": {
                        "color": "#333333",
                        "width": 1,
                    },
                },
                name=mode.button_label,
                meta={"role": "aggregate"},
                customdata=aggregate_customdata,
                showlegend=False,
                visible=mode_index == 0,
                hovertemplate=mode.hovertemplate,
            )
        )

    for player_id, player_data in by_player.groupby(player_col):
        complete_player_data = (
            all_kits[["kit_id", "kit_name"]]
            .merge(
                player_data[["kit_id", player_value_col]],
                on="kit_id",
                how="left",
            )
            .fillna({player_value_col: 0})
        )
        fig.add_trace(
            go.Bar(
                x=complete_player_data["kit_name"],
                y=complete_player_data[player_value_col],
                name=str(player_id),
                meta={
                    "role": "player",
                    "playerId": str(player_id),
                    "highlightGroup": "player",
                    "highlightValue": str(player_id),
                },
                customdata=np.full(
                    (len(complete_player_data), 1),
                    str(player_id),
                ),
                showlegend=False,
                visible=False,
                hovertemplate=(
                    "<b>%{x}</b><br>"
                    "Player ID: %{customdata[0]}<br>"
                    f"{metric_views[0].yaxis_title}: "
                    f"%{{y:{player_value_format}}}"
                    "<extra></extra>"
                ),
            )
        )

    aggregate_count = len(metric_views)
    player_count = len(fig.data) - aggregate_count

    def aggregate_visibility(mode_index: int) -> list[bool]:
        return [
            index == mode_index for index in range(aggregate_count)
        ] + [False] * player_count

    players_visible = [False] * aggregate_count + [True] * player_count
    first_mode = metric_views[0]
    resolved_player_title = player_title or (
        f"{first_mode.title} — player contribution"
    )

    def reference_shapes(mode: AggregateMetricView) -> list[dict[str, object]]:
        return [
            {
                "type": "line",
                "xref": "paper",
                "yref": "y",
                "x0": 0,
                "x1": 1,
                "y0": reference.value,
                "y1": reference.value,
                "line": {
                    "color": reference.color,
                    "width": reference.width,
                    "dash": reference.dash,
                },
                "layer": "above",
            }
            for reference in mode.reference_lines
        ]

    def reference_annotations(
        mode: AggregateMetricView,
    ) -> list[dict[str, object]]:
        return [
            {
                "xref": "paper",
                "yref": "y",
                "x": 0.995,
                "y": reference.value,
                "xanchor": "right",
                "yanchor": "bottom",
                "text": reference.label,
                "showarrow": False,
                "font": {"size": 11, "color": reference.color},
                "bgcolor": "rgba(255,255,255,0.82)",
                "borderpad": 2,
            }
            for reference in mode.reference_lines
        ]

    mode_buttons = []
    for mode_index, mode in enumerate(metric_views):
        mode_buttons.append(
            {
                "label": mode.button_label,
                "method": "update",
                "args": [
                    {"visible": aggregate_visibility(mode_index)},
                    {
                        "barmode": "group",
                        "title": {"text": mode.title},
                        "yaxis": {
                            "title": {"text": mode.yaxis_title},
                            "tickformat": mode.tickformat,
                            "rangemode": "tozero",
                            "range": mode.yaxis_range,
                            "autorange": mode.yaxis_range is None,
                        },
                        "shapes": reference_shapes(mode),
                        "annotations": reference_annotations(mode),
                    },
                ],
            }
        )
    if player_count:
        mode_buttons.insert(
            1,
            {
                "label": "By player",
                "method": "update",
                "args": [
                    {"visible": players_visible},
                    {
                        "barmode": "stack",
                        "title": {
                            "text": resolved_player_title
                        },
                        "yaxis": {
                            "title": {"text": first_mode.yaxis_title},
                            "tickformat": first_mode.tickformat,
                            "rangemode": "tozero",
                            "range": None,
                            "autorange": True,
                        },
                        "shapes": [],
                        "annotations": [],
                    },
                ],
            },
        )

    fig.update_layout(
        title=first_mode.title,
        xaxis_title="Kit",
        yaxis_title=first_mode.yaxis_title,
        barmode="group",
        clickmode="event",
        hovermode="closest",
        margin=dict(l=60, r=30, t=125, b=60),
        shapes=reference_shapes(first_mode),
        annotations=reference_annotations(first_mode),
        updatemenus=[
            {
                "type": "buttons",
                "direction": "right",
                "x": 0.5,
                "xanchor": "center",
                "y": 1.20,
                "yanchor": "top",
                "showactive": True,
                "buttons": mode_buttons,
            }
        ],
    )
    fig.update_yaxes(
        tickformat=first_mode.tickformat,
        rangemode="tozero",
    )
    fig.update_xaxes(categoryorder="array", categoryarray=KIT_ORDER)

    return fig

def _show_click_highlight_figure(fig: go.Figure) -> None:
    """Display a figure with browser-side trace-group highlighting."""

    from IPython.display import HTML, display

    html = fig.to_html(
        full_html=False,
        include_plotlyjs=True,
        post_script=TRACE_HIGHLIGHT_POST_SCRIPT,
    )
    display(HTML(html))


def show_player_contribution_figure(fig: go.Figure) -> None:
    """Display a contribution chart with click-to-focus player traces."""

    _show_click_highlight_figure(fig)


def show_cause_profile_figure(fig: go.Figure) -> None:
    """Display a cause-profile chart with click-to-focus cause traces."""

    _show_click_highlight_figure(fig)

def concentration_figure(
    stats: pd.DataFrame,
    *,
    views: Sequence[ConcentrationView],
) -> go.Figure:
    """Toggle among contributor-concentration measures in one figure."""

    if not views:
        raise ValueError("views must contain at least one concentration mode")

    fig = go.Figure()
    category_orders: list[list[str]] = []
    traces_per_view = 4
    for view_index, view in enumerate(views):
        plot_data = stats.loc[
            stats[view.total_col] > 0,
            [
                "kit_name",
                view.top_player_col,
                view.top_three_col,
                view.players_col,
            ],
        ].sort_values(view.top_player_col, ascending=False)

        plot_data = plot_data.copy()
        plot_data["players_2_3_share"] = (
            plot_data[view.top_three_col]
            - plot_data[view.top_player_col]
        ).clip(lower=0)
        plot_data["remaining_share"] = (
            1 - plot_data[view.top_three_col]
        ).clip(lower=0)
        contributor_counts = plot_data[view.players_col].astype(int)
        category_orders.append(plot_data["kit_name"].tolist())

        for column, label, color in (
            (view.top_player_col, "Top player", "#7F1D1D"),
            ("players_2_3_share", "Players 2–3", "#D97706"),
            ("remaining_share", "Everyone else", "#94A3B8"),
        ):
            fig.add_trace(
                go.Bar(
                    x=plot_data["kit_name"],
                    y=plot_data[column],
                    name=label,
                    marker_color=color,
                    customdata=np.column_stack([contributor_counts]),
                    visible=view_index == 0,
                    hovertemplate=(
                        f"<b>%{{x}}</b><br>{label}: %{{y:.1%}}<br>"
                        "Contributors: %{customdata[0]:.0f}"
                        "<extra></extra>"
                    ),
                )
            )
        fig.add_trace(
            go.Scatter(
                x=plot_data["kit_name"],
                y=np.full(len(plot_data), 1.025),
                mode="text",
                text=[f"n={count}" for count in contributor_counts],
                textfont=dict(color="#475569", size=11),
                hoverinfo="skip",
                showlegend=False,
                cliponaxis=False,
                visible=view_index == 0,
            )
        )

    first_view = views[0]
    fig.update_layout(
        title=first_view.title,
        xaxis_title="Kit",
        yaxis_title=first_view.yaxis_title,
        barmode="stack",
        legend_title_text="Share of total",
        margin=dict(l=60, r=30, t=125, b=60),
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
                        "label": view.button_label,
                        "method": "update",
                        "args": [
                            {
                                "visible": [
                                    trace_index // traces_per_view == view_index
                                    for trace_index in range(len(fig.data))
                                ]
                            },
                            {
                                "title": {"text": view.title},
                                "yaxis": {
                                    "title": {"text": view.yaxis_title},
                                    "tickformat": ".0%",
                                    "range": [0, 1.08],
                                },
                                "xaxis": {
                                    "title": {"text": "Kit"},
                                    "categoryorder": "array",
                                    "categoryarray": category_orders[view_index],
                                },
                            },
                        ],
                    }
                    for view_index, view in enumerate(views)
                ],
            }
        ],
    )
    fig.update_xaxes(
        categoryorder="array",
        categoryarray=category_orders[0],
    )
    fig.update_yaxes(tickformat=".0%", range=[0, 1.08])
    return fig

def _quadrant_modes_figure(
    data: pd.DataFrame,
    *,
    modes: Sequence[QuadrantMode],
    customdata_cols: Sequence[str] = (
        "ability_use",
        "kills",
        "total_hours",
        "completed_lives",
    ),
) -> go.Figure:
    """Build one kit-colored quadrant scatter with switchable axis metrics."""

    if not modes:
        raise ValueError("modes must contain at least one quadrant mode")

    plot_data = data.sort_values("kit_id").reset_index(drop=True)
    customdata = plot_data[list(customdata_cols)].to_numpy()
    first_mode = modes[0]
    mode_visibility = [
        plot_data[[mode.x_col, mode.y_col]]
        .replace([np.inf, -np.inf], np.nan)
        .notna()
        .all(axis=1)
        .tolist()
        for mode in modes
    ]
    fig = go.Figure()
    for row_index, row in plot_data.iterrows():
        kit_name = row["kit_name"]
        fig.add_trace(
            go.Scatter(
                x=[row[first_mode.x_col]],
                y=[row[first_mode.y_col]],
                mode="markers",
                name=kit_name,
                legendgroup=kit_name,
                marker=dict(
                    size=12,
                    color=KIT_COLORS[kit_name],
                    line=dict(color="#333333", width=1),
                ),
                customdata=[customdata[row_index]],
                hovertemplate=first_mode.hovertemplate,
                visible=mode_visibility[0][row_index],
            )
        )

    layouts = [_quadrant_mode_layout(plot_data, mode) for mode in modes]
    first_layout = layouts[0]
    fig.update_layout(
        title=first_mode.title,
        legend_title_text="Kit",
        margin=dict(l=70, r=30, t=125, b=65),
        shapes=first_layout["shapes"],
        annotations=first_layout["annotations"],
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
                        "label": mode.button_label,
                        "method": "update",
                        "args": [
                            {
                                "x": [
                                    [value]
                                    for value in plot_data[mode.x_col]
                                ],
                                "y": [
                                    [value]
                                    for value in plot_data[mode.y_col]
                                ],
                                "hovertemplate": [
                                    mode.hovertemplate
                                ] * len(plot_data),
                                "visible": visibility,
                            },
                            {
                                "title": {"text": mode.title},
                                "xaxis": layout["xaxis"],
                                "yaxis": layout["yaxis"],
                                "shapes": layout["shapes"],
                                "annotations": layout["annotations"],
                            },
                        ],
                    }
                    for mode, layout, visibility in zip(
                        modes,
                        layouts,
                        mode_visibility,
                    )
                ],
            }
        ],
    )
    fig.update_xaxes(**first_layout["xaxis"])
    fig.update_yaxes(**first_layout["yaxis"])
    return fig


def _quadrant_mode_layout(
    data: pd.DataFrame,
    mode: QuadrantMode,
) -> dict[str, object]:
    """Calculate axes, median guides, and quadrant labels for one mode."""

    finite = data[[mode.x_col, mode.y_col]].replace(
        [np.inf, -np.inf], np.nan
    ).dropna()
    if finite.empty:
        return {
            "xaxis": {
                "title": {"text": mode.xaxis_title},
                "range": [0, 1],
                "tickformat": mode.x_tickformat,
            },
            "yaxis": {
                "title": {"text": mode.yaxis_title},
                "range": [0, 1],
                "tickformat": mode.y_tickformat,
            },
            "shapes": [],
            "annotations": [],
        }

    x_mid = float(finite[mode.x_col].median())
    y_mid = float(finite[mode.y_col].median())
    x_range = _padded_axis_range(
        finite[mode.x_col], minimum_padding=0.01
    )
    y_range = _padded_axis_range(
        finite[mode.y_col], minimum_padding=0.01
    )
    positions = (
        ((x_range[0] + x_mid) / 2, (y_mid + y_range[1]) / 2),
        ((x_mid + x_range[1]) / 2, (y_mid + y_range[1]) / 2),
        ((x_range[0] + x_mid) / 2, (y_range[0] + y_mid) / 2),
        ((x_mid + x_range[1]) / 2, (y_range[0] + y_mid) / 2),
    )
    return {
        "xaxis": {
            "title": {"text": mode.xaxis_title},
            "range": x_range,
            "tickformat": mode.x_tickformat,
        },
        "yaxis": {
            "title": {"text": mode.yaxis_title},
            "range": y_range,
            "tickformat": mode.y_tickformat,
        },
        "shapes": [
            {
                "type": "line",
                "xref": "x",
                "yref": "y",
                "x0": x_mid,
                "x1": x_mid,
                "y0": y_range[0],
                "y1": y_range[1],
                "line": {"color": "#777777", "dash": "dash"},
            },
            {
                "type": "line",
                "xref": "x",
                "yref": "y",
                "x0": x_range[0],
                "x1": x_range[1],
                "y0": y_mid,
                "y1": y_mid,
                "line": {"color": "#777777", "dash": "dash"},
            },
        ],
        "annotations": [
            {
                "x": x,
                "y": y,
                "xref": "x",
                "yref": "y",
                "text": label,
                "showarrow": False,
                "font": {"size": 11, "color": "#555555"},
                "bgcolor": "rgba(255,255,255,0.72)",
            }
            for (x, y), label in zip(positions, mode.quadrant_labels)
        ],
    }


def _quadrant_scatter_figure(
    data: pd.DataFrame,
    *,
    x_col: str,
    y_col: str,
    title: str,
    labels: dict[str, str],
    hover_data: dict[str, object],
    quadrant_labels: tuple[str, str, str, str],
    x_tickformat: str | None = None,
    y_tickformat: str | None = None,
    x_reference: float | None = None,
    y_reference: float | None = None,
    x_upper_bound: float | None = None,
    y_upper_bound: float | None = None,
    x_padding_fraction: float = 0.08,
    y_padding_fraction: float = 0.08,
    x_minimum_padding: float = 1,
    y_minimum_padding: float = 1,
) -> go.Figure:
    """Build the common kit-colored, reference-quadrant scatter layout."""

    if data.empty:
        fig = go.Figure()
        fig.update_layout(
            title=title,
            xaxis_title=labels[x_col],
            yaxis_title=labels[y_col],
        )
        return fig

    x_mid = (
        float(x_reference)
        if x_reference is not None
        else float(data[x_col].median())
    )
    y_mid = (
        float(y_reference)
        if y_reference is not None
        else float(data[y_col].median())
    )
    x_values = pd.concat(
        [data[x_col], pd.Series([x_mid])], ignore_index=True
    )
    y_values = pd.concat(
        [data[y_col], pd.Series([y_mid])], ignore_index=True
    )
    x_range = _padded_axis_range(
        x_values,
        padding_fraction=x_padding_fraction,
        minimum_padding=x_minimum_padding,
        upper_bound=x_upper_bound,
    )
    y_range = _padded_axis_range(
        y_values,
        padding_fraction=y_padding_fraction,
        minimum_padding=y_minimum_padding,
        upper_bound=y_upper_bound,
    )

    fig = px.scatter(
        data,
        x=x_col,
        y=y_col,
        color="kit_name",
        color_discrete_map=KIT_COLORS,
        hover_name="kit_name",
        hover_data=hover_data,
        labels=labels,
        title=title,
    )
    fig.update_traces(
        marker=dict(size=12, line=dict(color="#333333", width=1))
    )
    fig.add_vline(x=x_mid, line_dash="dash", line_color="#777777")
    fig.add_hline(y=y_mid, line_dash="dash", line_color="#777777")

    quadrant_positions = (
        ((x_range[0] + x_mid) / 2, (y_mid + y_range[1]) / 2),
        ((x_mid + x_range[1]) / 2, (y_mid + y_range[1]) / 2),
        ((x_range[0] + x_mid) / 2, (y_range[0] + y_mid) / 2),
        ((x_mid + x_range[1]) / 2, (y_range[0] + y_mid) / 2),
    )
    for (x, y), label in zip(quadrant_positions, quadrant_labels):
        fig.add_annotation(
            x=x,
            y=y,
            text=label,
            showarrow=False,
            font=dict(size=11, color="#555555"),
            bgcolor="rgba(255,255,255,0.72)",
        )

    fig.update_layout(legend_title_text="Kit")
    fig.update_xaxes(tickformat=x_tickformat, range=x_range)
    fig.update_yaxes(tickformat=y_tickformat, range=y_range)
    return fig


def _padded_axis_range(
    values: pd.Series,
    *,
    padding_fraction: float = 0.08,
    minimum_padding: float = 1,
    upper_bound: float | None = None,
) -> list[float]:
    """Return a non-negative axis range with modest data-dependent padding."""

    minimum = float(values.min())
    maximum = float(values.max())
    span = maximum - minimum
    padding = max(span * padding_fraction, maximum * 0.03, minimum_padding)
    lower = max(0.0, minimum - padding)
    upper = maximum + padding
    if upper_bound is not None:
        upper = min(upper_bound, upper)
    if upper <= lower:
        upper = lower + minimum_padding
    return [lower, upper]


def relative_metric_heatmap(
    summary: pd.DataFrame,
    metric_specs: Sequence[MetricSpec],
    *,
    title: str,
) -> go.Figure:
    """Normalize each metric independently and render a comparable profile."""

    z_rows: list[np.ndarray] = []
    hover_rows: list[list[str]] = []

    for column, label, kind in metric_specs:
        values = pd.to_numeric(summary[column], errors="coerce").to_numpy(
            dtype=float
        )
        finite = values[np.isfinite(values)]
        max_value = finite.max() if finite.size else 0.0
        z_rows.append(values / max_value if max_value > 0 else np.zeros_like(values))

        row_hover = []
        for kit_name, value in zip(summary["kit_name"], values):
            if not np.isfinite(value):
                formatted = "No data"
            elif kind == "percent":
                formatted = f"{value:.1%}"
            else:
                formatted = f"{int(value):,}"
            row_hover.append(f"{kit_name}<br>{label}: {formatted}")
        hover_rows.append(row_hover)

    fig = go.Figure(
        go.Heatmap(
            z=np.array(z_rows),
            x=summary["kit_name"],
            y=[label for _, label, _ in metric_specs],
            customdata=np.array(hover_rows),
            zmin=0,
            zmax=1,
            hovertemplate="%{customdata}<extra></extra>",
            colorbar=dict(
                title="Relative level",
                tickvals=[0, 0.5, 1],
                ticktext=["Low", "Mid", "Highest"],
            ),
        )
    )
    fig.update_layout(title=title, xaxis_title="Kit", yaxis_title="")
    return fig

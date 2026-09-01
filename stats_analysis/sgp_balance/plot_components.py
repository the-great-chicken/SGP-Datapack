"""Reusable interactive Plotly components for the SGP report.

This module owns generic chart mechanics: buttons, visibility masks, player
highlighting, concentration composition, and median-quadrant layouts.  The
SGP-specific choice of metrics and report story remain in :mod:`sgp_report`.
"""

from __future__ import annotations

from dataclasses import dataclass
from importlib import import_module
from typing import Any, Literal, Sequence, TypedDict, cast

import numpy as np
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go

from .core import KIT_ORDER, ReportData


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
CONTRIBUTOR_RANK_COLORSCALE = (
    (0.0, "#17324D"),
    (0.35, "#2F6F9F"),
    (0.7, "#78B6D6"),
    (1.0, "#C7E5F1"),
)
STANDARD_FIGURE_HEIGHT = 680

MetricKind = Literal["count", "percent"]
MetricSpec = tuple[str, str, MetricKind]


class _QuadrantLayout(TypedDict):
    """Plotly-ready layout fragments for one quadrant mode."""

    xaxis: dict[str, Any]
    yaxis: dict[str, Any]
    shapes: list[dict[str, Any]]
    annotations: list[dict[str, Any]]


def _trace_count(fig: go.Figure) -> int:
    """Return a figure's trace count across Plotly stub versions."""

    return len(cast(Sequence[object], fig.data))


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
    mark_type: Literal["bar", "lollipop"] = "bar"
    lollipop_baseline: float = 1.0


@dataclass(frozen=True)
class ConcentrationView:
    """Metric and display labels for one contributor-concentration mode."""

    button_label: str
    metric_id: str
    title: str
    yaxis_title: str
    value_label: str
    value_format: str
    value_suffix: str = ""


@dataclass(frozen=True)
class QuadrantMode:
    """Axes and optional annotations for one scatter mode."""

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
    x_reference: float | None = None
    y_reference: float | None = None
    x_lower_bound: float | None = 0.0
    y_lower_bound: float | None = 0.0
    x_upper_bound: float | None = None
    y_upper_bound: float | None = None
    x_padding_fraction: float = 0.08
    y_padding_fraction: float = 0.08
    x_minimum_padding: float = 0.01
    y_minimum_padding: float = 0.01
    show_quadrants: bool = True


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
    player_customdata_cols: Sequence[str] = (),
    player_hovertemplate: str | None = None,
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
        common_trace_properties = {
            "x": totals["kit_name"],
            "y": totals[mode.value_col],
            "name": mode.button_label,
            "meta": {"role": "aggregate"},
            "customdata": aggregate_customdata,
            "showlegend": False,
            "visible": mode_index == 0,
            "hovertemplate": mode.hovertemplate,
        }
        if mode.mark_type == "lollipop":
            aggregate_trace = go.Scatter(
                **common_trace_properties,
                mode="markers",
                marker={
                    "size": 13,
                    "color": totals["kit_name"].map(KIT_COLORS),
                    "line": {
                        "color": "#333333",
                        "width": 1,
                    },
                },
            )
        else:
            aggregate_trace = go.Bar(
                **common_trace_properties,
                marker={
                    "color": totals["kit_name"].map(KIT_COLORS),
                    "line": {
                        "color": "#333333",
                        "width": 1,
                    },
                },
            )
        fig.add_trace(aggregate_trace)

    for player_id, player_data in by_player.groupby(player_col):
        player_columns = [
            "kit_id",
            player_value_col,
            *player_customdata_cols,
        ]
        complete_player_data = (
            all_kits[["kit_id", "kit_name"]]
            .merge(
                player_data[player_columns],
                on="kit_id",
                how="left",
            )
            .fillna({player_value_col: 0})
        )
        player_customdata = np.column_stack(
            [
                np.full(len(complete_player_data), str(player_id)),
                *(
                    complete_player_data[column]
                    for column in player_customdata_cols
                ),
            ]
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
                customdata=player_customdata,
                showlegend=False,
                visible=False,
                hovertemplate=player_hovertemplate
                or (
                    "<b>%{x}</b><br>"
                    "Player ID: %{customdata[0]}<br>"
                    f"{metric_views[0].yaxis_title}: "
                    f"%{{y:{player_value_format}}}"
                    "<extra></extra>"
                ),
            )
        )

    aggregate_count = len(metric_views)
    player_count = _trace_count(fig) - aggregate_count

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
        shapes: list[dict[str, object]] = [
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
        if mode.mark_type == "lollipop":
            values = pd.to_numeric(
                totals[mode.value_col], errors="coerce"
            ).replace([np.inf, -np.inf], np.nan)
            for kit_name, value in zip(totals["kit_name"], values):
                if pd.isna(value):
                    continue
                shapes.append(
                    {
                        "type": "line",
                        "xref": "x",
                        "yref": "y",
                        "x0": kit_name,
                        "x1": kit_name,
                        "y0": mode.lollipop_baseline,
                        "y1": float(value),
                        "line": {
                            "color": "#9CA3AF",
                            "width": 2,
                        },
                        "layer": "below",
                    }
                )
        return shapes

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
                            "rangemode": (
                                "normal"
                                if mode.mark_type == "lollipop"
                                else "tozero"
                            ),
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
        height=STANDARD_FIGURE_HEIGHT,
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
                "y": 1.11,
                "yanchor": "top",
                "showactive": True,
                "buttons": mode_buttons,
            }
        ],
    )
    fig.update_yaxes(
        tickformat=first_mode.tickformat,
        rangemode=(
            "normal"
            if first_mode.mark_type == "lollipop"
            else "tozero"
        ),
        range=first_mode.yaxis_range,
    )
    fig.update_xaxes(categoryorder="array", categoryarray=KIT_ORDER)

    return fig

def _show_click_highlight_figure(fig: go.Figure) -> None:
    """Display a figure with browser-side trace-group highlighting."""

    display_module = import_module("IPython.display")
    html_fragment = display_module.HTML
    display = display_module.display

    html = fig.to_html(
        full_html=False,
        include_plotlyjs=True,
        post_script=TRACE_HIGHLIGHT_POST_SCRIPT,
    )
    display(html_fragment(html))


def show_player_contribution_figure(fig: go.Figure) -> None:
    """Display a contribution chart with click-to-focus player traces."""

    _show_click_highlight_figure(fig)


def show_cause_profile_figure(fig: go.Figure) -> None:
    """Display a cause-profile chart with click-to-focus cause traces."""

    _show_click_highlight_figure(fig)


def concentration_figure(
    profiles: pd.DataFrame,
    *,
    views: Sequence[ConcentrationView],
) -> go.Figure:
    """Toggle ranked-player stacks across output and exposure measures."""

    if not views:
        raise ValueError("views must contain at least one concentration mode")

    fig = go.Figure()
    category_orders: list[list[str]] = []
    trace_view_indices: list[int] = []
    for view_index, view in enumerate(views):
        plot_data = profiles.loc[
            profiles["metric_id"] == view.metric_id
        ].copy()
        leaders = plot_data.loc[plot_data["rank"] == 1].sort_values(
            ["share", "kit_id"],
            ascending=[False, True],
            kind="stable",
        )
        order = leaders["kit_name"].tolist()
        category_orders.append(order)
        maximum_rank = (
            int(plot_data["rank"].max()) if not plot_data.empty else 0
        )
        hovertemplate = (
            "<b>%{x}</b><br>Player rank: "
            "%{customdata[1]:.0f} of %{customdata[2]:.0f}<br>"
            "Player ID: %{customdata[0]}<br>"
            f"{view.value_label}: "
            f"%{{customdata[3]:{view.value_format}}}"
            f"{view.value_suffix}<br>"
            f"{view.yaxis_title}: %{{y:.1%}}<br>"
            "Cumulative share through this rank: "
            "%{customdata[4]:.1%}<br>Top-three share: "
            "%{customdata[5]:.1%}<extra></extra>"
        )

        for rank in range(1, maximum_rank + 1):
            rank_data = (
                plot_data.loc[plot_data["rank"] == rank]
                .set_index("kit_name")
                .reindex(order)
            )
            fig.add_trace(
                go.Bar(
                    x=order,
                    y=rank_data["share"],
                    name=f"Player rank {rank}",
                    marker=dict(
                        color=rank_data["rank_fraction"],
                        colorscale=CONTRIBUTOR_RANK_COLORSCALE,
                        cmin=0,
                        cmax=1,
                        showscale=rank == 1,
                        colorbar=dict(
                            title=dict(text="Rank within kit"),
                            tickvals=[0, 1],
                            ticktext=["Top", "Last"],
                            len=0.42,
                            thickness=14,
                        ),
                        line=dict(
                            color="rgba(31,41,55,0.35)",
                            width=0.4,
                        ),
                    ),
                    customdata=np.column_stack(
                        [
                            rank_data["player_id"],
                            rank_data["rank"],
                            rank_data["contributors"],
                            rank_data["value"],
                            rank_data["cumulative_share"],
                            rank_data["top_three_share"],
                        ]
                    ),
                    visible=view_index == 0,
                    hovertemplate=hovertemplate,
                    showlegend=False,
                )
            )
            trace_view_indices.append(view_index)

        fig.add_trace(
            go.Scatter(
                x=order,
                y=leaders["top_three_share"],
                mode="markers",
                marker=dict(
                    symbol="line-ew",
                    size=24,
                    color="#374151",
                    line=dict(color="#374151", width=2),
                ),
                hoverinfo="skip",
                showlegend=False,
                visible=view_index == 0,
            )
        )
        trace_view_indices.append(view_index)
        fig.add_trace(
            go.Scatter(
                x=order,
                y=np.full(len(leaders), 1.03),
                mode="text",
                text=[
                    f"n={int(count)}" for count in leaders["contributors"]
                ],
                textfont=dict(color="#475569", size=11),
                hoverinfo="skip",
                showlegend=False,
                cliponaxis=False,
                visible=view_index == 0,
            )
        )
        trace_view_indices.append(view_index)

    first_view = views[0]
    fig.update_layout(
        title=first_view.title,
        height=STANDARD_FIGURE_HEIGHT,
        xaxis_title="Kit",
        yaxis_title=first_view.yaxis_title,
        barmode="stack",
        hovermode="closest",
        showlegend=False,
        margin=dict(l=60, r=100, t=125, b=60),
        updatemenus=[
            {
                "type": "buttons",
                "direction": "right",
                "x": 0.5,
                "xanchor": "center",
                "y": 1.11,
                "yanchor": "top",
                "showactive": True,
                "buttons": [
                    {
                        "label": view.button_label,
                        "method": "update",
                        "args": [
                            {
                                "visible": [
                                    trace_view_index == view_index
                                    for trace_view_index in trace_view_indices
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
    for row_index, (_, row) in enumerate(plot_data.iterrows()):
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
        height=STANDARD_FIGURE_HEIGHT,
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
                "y": 1.11,
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
) -> _QuadrantLayout:
    """Calculate axes and optional reference quadrants for one mode."""

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

    x_mid = (
        float(mode.x_reference)
        if mode.x_reference is not None
        else float(finite[mode.x_col].median())
    )
    y_mid = (
        float(mode.y_reference)
        if mode.y_reference is not None
        else float(finite[mode.y_col].median())
    )
    x_values = pd.concat(
        [finite[mode.x_col], pd.Series([x_mid])],
        ignore_index=True,
    )
    y_values = pd.concat(
        [finite[mode.y_col], pd.Series([y_mid])],
        ignore_index=True,
    )
    x_range = _padded_axis_range(
        x_values,
        padding_fraction=mode.x_padding_fraction,
        minimum_padding=mode.x_minimum_padding,
        lower_bound=mode.x_lower_bound,
        upper_bound=mode.x_upper_bound,
    )
    y_range = _padded_axis_range(
        y_values,
        padding_fraction=mode.y_padding_fraction,
        minimum_padding=mode.y_minimum_padding,
        lower_bound=mode.y_lower_bound,
        upper_bound=mode.y_upper_bound,
    )
    axes = {
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
    }
    if not mode.show_quadrants:
        return {
            **axes,
            "shapes": [],
            "annotations": [],
        }

    positions = (
        ((x_range[0] + x_mid) / 2, (y_mid + y_range[1]) / 2),
        ((x_mid + x_range[1]) / 2, (y_mid + y_range[1]) / 2),
        ((x_range[0] + x_mid) / 2, (y_range[0] + y_mid) / 2),
        ((x_mid + x_range[1]) / 2, (y_range[0] + y_mid) / 2),
    )
    return {
        **axes,
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
            height=STANDARD_FIGURE_HEIGHT,
            margin=dict(l=70, r=30, t=90, b=70),
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
    for trace in cast(Sequence[Any], fig.data):
        if trace.hovertemplate:
            trace.hovertemplate = trace.hovertemplate.replace("=", ": ")
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

    fig.update_layout(
        height=STANDARD_FIGURE_HEIGHT,
        legend_title_text="Kit",
        margin=dict(l=70, r=30, t=90, b=70),
    )
    fig.update_xaxes(tickformat=x_tickformat, range=x_range)
    fig.update_yaxes(tickformat=y_tickformat, range=y_range)
    return fig


def _padded_axis_range(
    values: pd.Series,
    *,
    padding_fraction: float = 0.08,
    minimum_padding: float = 1,
    lower_bound: float | None = 0.0,
    upper_bound: float | None = None,
) -> list[float]:
    """Return a bounded axis range with modest data-dependent padding."""

    minimum = float(values.min())
    maximum = float(values.max())
    span = maximum - minimum
    magnitude = max(abs(minimum), abs(maximum))
    padding = max(span * padding_fraction, magnitude * 0.03, minimum_padding)
    lower = minimum - padding
    if lower_bound is not None:
        lower = max(lower_bound, lower)
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


def _elo_name(report: ReportData) -> str:
    """Return the authoritative display name for the Elo snapshot."""

    if report.elo_metadata.empty:
        return "Kill Elo"
    return str(report.elo_metadata["elo_name"].iloc[0])


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

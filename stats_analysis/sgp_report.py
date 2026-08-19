"""Data preparation and reusable visual components for the SGP kit report.

The notebook keeps the report-specific story and one-off plots. This module owns
the less interesting plumbing: loading and validating the extracts, deriving
the shared analysis tables, and rendering chart patterns that occur more than
once.
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Literal, Sequence

import numpy as np
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from plotly.colors import qualitative
from plotly.subplots import make_subplots


KIT_NAMES = (
    "pigeon",
    "combattant",
    "archer",
    "vindicateur",
    "pyromane",
    "tank",
    "roi",
    "eclaireur",
    "alchimiste",
    "enderman",
    "cancer",
    "poseidon",
)
KIT_ID_TO_NAME = dict(enumerate(KIT_NAMES))
KIT_ORDER = KIT_NAMES

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

KILL_COLUMNS = ("id_killer", "kit_id_killer", "kit_id_victim", "kills")
ABILITY_COLUMNS = ("id", "kit_id", "ability_use")

MetricKind = Literal["count", "percent"]
MetricSpec = tuple[str, str, MetricKind]
PLAYER_DIM_OPACITY = 0.15
PLAYER_HIGHLIGHT_POST_SCRIPT = f"""
(() => {{
    const plot = document.getElementById("{{plot_id}}");
    const dimOpacity = {PLAYER_DIM_OPACITY};
    let selectedPlayerId = null;

    plot.on("plotly_click", (event) => {{
        const point = event.points && event.points[0];
        if (!point || point.curveNumber === 0) {{
            return;
        }}

        const clickedPlayerId = plot.data[point.curveNumber].name;
        selectedPlayerId =
            selectedPlayerId === clickedPlayerId
                ? null
                : clickedPlayerId;

        const playerTraceIndices = plot.data
            .map((_, traceIndex) => traceIndex)
            .slice(1);
        const opacities = playerTraceIndices.map((traceIndex) =>
            selectedPlayerId === null ||
            plot.data[traceIndex].name === selectedPlayerId
                ? 1
                : dimOpacity
        );

        Plotly.restyle(
            plot,
            {{ opacity: opacities }},
            playerTraceIndices
        );
    }});
}})();
"""


@dataclass(frozen=True)
class ReportData:
    """Validated inputs and the shared tables consumed throughout the report."""

    kills: pd.DataFrame
    abilities: pd.DataFrame
    all_kits: pd.DataFrame
    player_kit_kills: pd.DataFrame
    total_kills_by_kit: pd.DataFrame
    kit_kill_stats: pd.DataFrame
    matchup_matrix: pd.DataFrame
    directional_share: np.ndarray
    pair_totals: np.ndarray
    player_kit_abilities: pd.DataFrame
    total_abilities_by_kit: pd.DataFrame
    kit_ability_stats: pd.DataFrame
    reach: pd.DataFrame
    combined_totals: pd.DataFrame
    summary: pd.DataFrame
    n_players: int


def load_report_data(data_dir: str | Path = "data") -> ReportData:
    """Load the two normalized extracts and prepare all shared report tables."""

    data_dir = Path(data_dir)
    kills = pd.read_parquet(data_dir / "kills.parquet")
    abilities = pd.read_parquet(data_dir / "abilities.parquet")
    return prepare_report_data(kills, abilities)


def prepare_report_data(
    kills: pd.DataFrame,
    abilities: pd.DataFrame,
) -> ReportData:
    """Validate normalized inputs and derive the report's reusable datasets."""

    kills, abilities = _validate_and_normalize(kills, abilities)
    all_kits = pd.DataFrame(
        {
            "kit_id": list(KIT_ID_TO_NAME),
            "kit_name": list(KIT_ID_TO_NAME.values()),
        }
    )

    player_kit_kills = (
        kills.groupby(["id_killer", "kit_id_killer"], as_index=False)["kills"]
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
        total_kills_by_kit.merge(kill_concentration, on="kit_id", how="left")
        .sort_values("kit_id")
        .reset_index(drop=True)
    )
    kit_kill_stats["players"] = pd.to_numeric(
        kit_kill_stats["players"],
        errors="coerce",
    ).fillna(0).astype(int)

    matchup_counts = kills.groupby(
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

    player_kit_abilities = (
        abilities.loc[abilities["ability_use"] > 0]
        .groupby(["id", "kit_id"], as_index=False)["ability_use"]
        .sum()
    )
    player_kit_abilities["kit_name"] = player_kit_abilities["kit_id"].map(
        KIT_ID_TO_NAME
    )
    total_abilities_by_kit = _complete_metric_totals(
        player_kit_abilities,
        all_kits,
        "ability_use",
    )
    ability_concentration = _concentration_from_counts(
        player_kit_abilities.rename(columns={"ability_use": "value"}),
        group_col="kit_id",
        value_col="value",
    ).rename(
        columns={
            "players": "players_using_ability",
            "top_player_share": "top_player_ability_share",
            "top_3_share": "top_3_ability_share",
        }
    )
    kit_ability_stats = (
        total_abilities_by_kit.merge(
            ability_concentration,
            on="kit_id",
            how="left",
        )
        .sort_values("kit_id")
        .reset_index(drop=True)
    )
    kit_ability_stats["players_using_ability"] = pd.to_numeric(
        kit_ability_stats["players_using_ability"],
        errors="coerce",
    ).fillna(0).astype(int)

    all_player_ids = set(kills["id_killer"]) | set(abilities["id"])
    n_players = len(all_player_ids)
    reach = _build_reach(
        player_kit_kills,
        player_kit_abilities,
        n_players,
    )

    combined_totals = (
        all_kits.merge(
            total_kills_by_kit[["kit_id", "kills"]],
            on="kit_id",
            how="left",
        )
        .merge(
            total_abilities_by_kit[["kit_id", "ability_use"]],
            on="kit_id",
            how="left",
        )
        .fillna({"kills": 0, "ability_use": 0})
    )
    combined_totals[["kills", "ability_use"]] = combined_totals[
        ["kills", "ability_use"]
    ].astype(int)

    summary = (
        all_kits.merge(
            kit_kill_stats[
                ["kit_id", "kills", "players", "top_player_share"]
            ].rename(columns={"players": "players_with_kills"}),
            on="kit_id",
            how="left",
        )
        .merge(
            kit_ability_stats[
                [
                    "kit_id",
                    "ability_use",
                    "players_using_ability",
                    "top_player_ability_share",
                ]
            ],
            on="kit_id",
            how="left",
        )
        .merge(
            reach[["kit_name", "made_kill", "used_ability"]],
            on="kit_name",
            how="left",
        )
    )

    return ReportData(
        kills=kills,
        abilities=abilities,
        all_kits=all_kits,
        player_kit_kills=player_kit_kills,
        total_kills_by_kit=total_kills_by_kit,
        kit_kill_stats=kit_kill_stats,
        matchup_matrix=matchup_matrix,
        directional_share=directional_share,
        pair_totals=pair_totals,
        player_kit_abilities=player_kit_abilities,
        total_abilities_by_kit=total_abilities_by_kit,
        kit_ability_stats=kit_ability_stats,
        reach=reach,
        combined_totals=combined_totals,
        summary=summary,
        n_players=n_players,
    )


def player_contribution_figure(
    *,
    all_kits: pd.DataFrame,
    totals: pd.DataFrame,
    by_player: pd.DataFrame,
    player_col: str,
    value_col: str,
    title: str,
    yaxis_title: str,
    total_button_label: str,
) -> go.Figure:
    """Build the repeated total-versus-player-contribution bar interaction.

    In the player-stacked view, clicking any segment focuses that player's
    trace across every kit. Clicking the focused player again restores all
    player colors.
    """

    fig = go.Figure()
    fig.add_trace(
        go.Bar(
            x=totals["kit_name"],
            y=totals[value_col],
            marker={
                "color": totals["kit_name"].map(KIT_COLORS),
                "line": {
                    "color": "#333333",
                    "width": 1,
                },
            },
            name=title,
            showlegend=False,
            visible=True,
            hovertemplate=(
                f"<b>%{{x}}</b><br>{yaxis_title}: %{{y}}<extra></extra>"
            ),
        )
    )

    for player_id, player_data in by_player.groupby(player_col):
        complete_player_data = (
            all_kits[["kit_id", "kit_name"]]
            .merge(
                player_data[["kit_id", value_col]],
                on="kit_id",
                how="left",
            )
            .fillna({value_col: 0})
        )
        fig.add_trace(
            go.Bar(
                x=complete_player_data["kit_name"],
                y=complete_player_data[value_col],
                name=str(player_id),
                customdata=np.full(
                    (len(complete_player_data), 1),
                    str(player_id),
                ),
                showlegend=False,
                visible=False,
                hovertemplate=(
                    "<b>%{x}</b><br>"
                    "Player ID: %{customdata[0]}<br>"
                    f"{yaxis_title}: %{{y}}<extra></extra>"
                ),
            )
        )

    total_visible = [True] + [False] * (len(fig.data) - 1)
    players_visible = [False] + [True] * (len(fig.data) - 1)
    fig.update_layout(
        title=title,
        xaxis_title="Kit",
        yaxis_title=yaxis_title,
        barmode="group",
        clickmode="event",
        hovermode="closest",
        margin=dict(l=60, r=30, t=115, b=60),
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
                        "label": total_button_label,
                        "method": "update",
                        "args": [
                            {"visible": total_visible},
                            {"barmode": "group", "title": title},
                        ],
                    },
                    {
                        "label": "By player",
                        "method": "update",
                        "args": [
                            {"visible": players_visible},
                            {
                                "barmode": "stack",
                                "title": f"{title} — player contribution",
                            },
                        ],
                    },
                ],
            }
        ],
    )
    fig.update_xaxes(categoryorder="array", categoryarray=KIT_ORDER)

    return fig


def total_kills_figure(report: ReportData) -> go.Figure:
    """Build the total-versus-player kill chart used in the report."""

    return player_contribution_figure(
        all_kits=report.all_kits,
        totals=report.total_kills_by_kit,
        by_player=report.player_kit_kills,
        player_col="id_killer",
        value_col="kills",
        title="Total kills by kit",
        yaxis_title="Kills",
        total_button_label="Total kills",
    )


def ability_uses_figure(report: ReportData) -> go.Figure:
    """Build the total-versus-player ability-use chart used in the report."""

    return player_contribution_figure(
        all_kits=report.all_kits,
        totals=report.total_abilities_by_kit,
        by_player=report.player_kit_abilities,
        player_col="id",
        value_col="ability_use",
        title="Ability uses by kit",
        yaxis_title="Ability uses",
        total_button_label="Total uses",
    )


def show_player_contribution_figure(fig: go.Figure) -> None:
    """Display a contribution chart with a browser-side player click handler."""

    from IPython.display import HTML, display

    html = fig.to_html(
        full_html=False,
        include_plotlyjs=True,
        post_script=PLAYER_HIGHLIGHT_POST_SCRIPT,
    )
    display(HTML(html))


def player_reach_figure(reach: pd.DataFrame, n_players: int) -> go.Figure:
    """Compare the two observed signals that a player tried a kit."""

    fig = go.Figure()
    denominator = np.full(len(reach), n_players)

    fig.add_trace(
        go.Bar(
            x=reach["kit_name"],
            y=reach["used_ability"],
            name="Used ability ≥ 1 time",
            customdata=np.column_stack(
                [reach["used_ability_count"], denominator]
            ),
            hovertemplate=(
                "<b>%{x}</b><br>"
                "Used ability: %{y:.1%}<br>"
                "Players: %{customdata[0]:.0f} / %{customdata[1]:.0f}"
                "<extra></extra>"
            ),
        )
    )
    fig.add_trace(
        go.Bar(
            x=reach["kit_name"],
            y=reach["made_kill"],
            name="Made ≥ 1 kill",
            customdata=np.column_stack(
                [reach["made_kill_count"], denominator]
            ),
            hovertemplate=(
                "<b>%{x}</b><br>"
                "Made a kill: %{y:.1%}<br>"
                "Players: %{customdata[0]:.0f} / %{customdata[1]:.0f}"
                "<extra></extra>"
            ),
        )
    )

    fig.update_layout(
        title="Proportion of observed players who tried each kit",
        xaxis_title="Kit",
        yaxis_title="Proportion of players",
        barmode="group",
    )
    fig.update_yaxes(tickformat=".0%", range=[0, 1])
    return fig


def concentration_figure(
    stats: pd.DataFrame,
    *,
    total_col: str,
    top_player_col: str,
    top_three_col: str,
    players_col: str,
    title: str,
    yaxis_title: str,
) -> go.Figure:
    """Show how each kit's activity is split across its contributors."""

    plot_data = stats.loc[
        stats[total_col] > 0,
        ["kit_name", top_player_col, top_three_col, players_col],
    ].sort_values(top_player_col, ascending=False)

    plot_data = plot_data.copy()
    plot_data["players_2_3_share"] = (
        plot_data[top_three_col] - plot_data[top_player_col]
    ).clip(lower=0)
    plot_data["remaining_share"] = (
        1 - plot_data[top_three_col]
    ).clip(lower=0)
    contributor_counts = plot_data[players_col].astype(int)

    fig = go.Figure()
    for column, label, color in (
        (top_player_col, "Top player", "#7F1D1D"),
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
        )
    )

    fig.update_layout(
        title=title,
        xaxis_title="Kit",
        yaxis_title=yaxis_title,
        barmode="stack",
        legend_title_text="Share of total",
    )
    fig.update_yaxes(tickformat=".0%", range=[0, 1.08])
    return fig


def kill_concentration_figure(stats: pd.DataFrame) -> go.Figure:
    """Build the kill-contributor composition chart used in the report."""

    return concentration_figure(
        stats,
        total_col="kills",
        top_player_col="top_player_share",
        top_three_col="top_3_share",
        players_col="players",
        title="Kill concentration by kit",
        yaxis_title="Share of kit kills",
    )


def kill_concentration_scatter_figure(stats: pd.DataFrame) -> go.Figure:
    """Relate total kills to top-player concentration for every active kit."""

    plot_data = stats.loc[
        stats["kills"] > 0,
        [
            "kit_name",
            "kills",
            "players",
            "top_player_share",
            "top_3_share",
        ],
    ].copy()

    return _quadrant_scatter_figure(
        plot_data,
        x_col="kills",
        y_col="top_player_share",
        title="Total kills vs. player concentration",
        labels={
            "kills": "Total kills",
            "top_player_share": "Top player's share of kit kills",
            "players": "Players with kills",
            "top_3_share": "Top 3 players' share",
            "kit_name": "Kit",
        },
        hover_data={
            "kills": True,
            "players": True,
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


def matchup_figure(
    matchup_matrix: pd.DataFrame,
    directional_share: np.ndarray,
    pair_totals: np.ndarray,
) -> go.Figure:
    """Toggle between directional matchup share and the raw kill matrix."""

    share_display = directional_share.copy()
    share_display[np.tril_indices(len(KIT_NAMES))] = np.nan
    share_hover = np.full_like(directional_share, "", dtype=object)

    for i, row_kit in enumerate(KIT_NAMES):
        for j, column_kit in enumerate(KIT_NAMES):
            if i >= j:
                continue

            if np.isnan(directional_share[i, j]):
                share_hover[i, j] = (
                    f"{row_kit} vs {column_kit}<br>"
                    "No kills observed in either direction"
                )
                continue

            share_hover[i, j] = (
                f"<b>{row_kit} vs {column_kit}</b><br>"
                f"{row_kit} kills: {matchup_matrix.iloc[i, j]}<br>"
                f"{column_kit} kills: {matchup_matrix.iloc[j, i]}<br>"
                f"{row_kit} directional share: "
                f"{directional_share[i, j]:.1%}<br>"
                f"Pair kills observed: {pair_totals[i, j]}"
            )

    fig = go.Figure()
    fig.add_trace(
        go.Heatmap(
            z=share_display,
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
            customdata=share_hover,
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
            hovertemplate=(
                "<b>%{y} → %{x}</b><br>"
                "Kills: %{z}<extra></extra>"
            ),
            colorbar=dict(title="Kills"),
            visible=False,
        )
    )

    fig.update_layout(
        title="Directional share of observed kills between kit pairs",
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
                "buttons": [
                    {
                        "label": "Directional share",
                        "method": "update",
                        "args": [
                            {"visible": [True, False]},
                            {
                                "title": (
                                    "Directional share of observed kills "
                                    "between kit pairs"
                                ),
                                "xaxis": {"title": "Other kit"},
                                "yaxis": {"title": "Row kit"},
                            },
                        ],
                    },
                    {
                        "label": "Raw kills",
                        "method": "update",
                        "args": [
                            {"visible": [False, True]},
                            {
                                "title": (
                                    "Kills by killer kit and victim kit"
                                ),
                                "xaxis": {"title": "Victim kit"},
                                "yaxis": {"title": "Killer kit"},
                            },
                        ],
                    },
                ],
            }
        ],
    )
    return fig


def kills_vs_ability_uses_figure(combined_totals: pd.DataFrame) -> go.Figure:
    """Compare aggregate ability-use and kill volume by kit."""

    return _quadrant_scatter_figure(
        combined_totals,
        x_col="ability_use",
        y_col="kills",
        title="Kills vs. ability uses by kit",
        labels={
            "ability_use": "Ability uses",
            "kills": "Kills",
            "kit_name": "Kit",
        },
        hover_data={
            "ability_use": True,
            "kills": True,
            "kit_name": False,
        },
        quadrant_labels=(
            "Low ability use<br>high kills",
            "High ability use<br>high kills",
            "Low ability use<br>low kills",
            "High ability use<br>low kills",
        ),
    )


def _quadrant_scatter_figure(
    data: pd.DataFrame,
    *,
    x_col: str,
    y_col: str,
    title: str,
    labels: dict[str, str],
    hover_data: dict[str, object],
    quadrant_labels: tuple[str, str, str, str],
    y_tickformat: str | None = None,
    y_upper_bound: float | None = None,
    y_padding_fraction: float = 0.08,
    y_minimum_padding: float = 1,
) -> go.Figure:
    """Build the common kit-colored, median-quadrant scatter layout."""

    if data.empty:
        fig = go.Figure()
        fig.update_layout(
            title=title,
            xaxis_title=labels[x_col],
            yaxis_title=labels[y_col],
        )
        return fig

    x_mid = data[x_col].median()
    y_mid = data[y_col].median()
    x_range = _padded_axis_range(data[x_col])
    y_range = _padded_axis_range(
        data[y_col],
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
    fig.update_xaxes(range=x_range)
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
            "Ability activity",
            "Player reach",
            "Kill concentration",
        ),
    )

    kill_hover = np.column_stack([plot_data["players_with_kills"]])
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
                "Players with ≥1 kill: %{customdata[0]:.0f}"
                "<extra></extra>"
            ),
            showlegend=False,
        ),
        row=1,
        col=1,
    )

    ability_hover = np.column_stack([plot_data["players_using_ability"]])
    fig.add_trace(
        go.Bar(
            x=plot_data["ability_use"],
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
            x=plot_data["ability_use"],
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
                "Ability uses: %{x:,}<br>"
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
    for kit_name, ability_reach, kill_reach in zip(
        kit_names,
        plot_data["used_ability"],
        plot_data["made_kill"],
    ):
        reach_line_x.extend([ability_reach, kill_reach, None])
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
                symbol="circle",
                line=dict(color=dark_outline, width=1.25),
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

    median_specs = (
        (1, plot_data["kills"]),
        (2, plot_data["ability_use"]),
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
    fig.add_vline(
        x=float(plot_data["used_ability"].median()),
        line=dict(color="#777777", width=1, dash="dot"),
        opacity=0.8,
        row=1,
        col=3,
    )
    fig.add_vline(
        x=float(plot_data["made_kill"].median()),
        line=dict(color="#A1A1AA", width=1, dash="dash"),
        opacity=0.8,
        row=1,
        col=3,
    )

    fig.update_xaxes(title_text="Kills", rangemode="tozero", row=1, col=1)
    fig.update_xaxes(
        title_text="Ability uses",
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
        title="Kit profile across the main report metrics",
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


def _validate_and_normalize(
    kills: pd.DataFrame,
    abilities: pd.DataFrame,
) -> tuple[pd.DataFrame, pd.DataFrame]:
    _require_columns(kills, KILL_COLUMNS, "kills")
    _require_columns(abilities, ABILITY_COLUMNS, "abilities")

    kills = kills.copy()
    abilities = abilities.copy()
    if kills[list(KILL_COLUMNS)].isna().any().any():
        raise ValueError("kills contains missing values")
    if abilities[list(ABILITY_COLUMNS)].isna().any().any():
        raise ValueError("abilities contains missing values")

    kills["id_killer"] = kills["id_killer"].astype(str)
    for column in ("kit_id_killer", "kit_id_victim", "kills"):
        kills[column] = pd.to_numeric(kills[column], errors="raise").astype(int)

    abilities["id"] = abilities["id"].astype(str)
    for column in ("kit_id", "ability_use"):
        abilities[column] = pd.to_numeric(
            abilities[column], errors="raise"
        ).astype(int)

    if (kills["kills"] < 0).any():
        raise ValueError("Negative kill count found")
    if (abilities["ability_use"] < 0).any():
        raise ValueError("Negative ability-use count found")
    if not kills["kit_id_killer"].isin(KIT_ID_TO_NAME).all():
        raise ValueError("Unknown killer kit ID found")
    if not kills["kit_id_victim"].isin(KIT_ID_TO_NAME).all():
        raise ValueError("Unknown victim kit ID found")
    if not abilities["kit_id"].isin(KIT_ID_TO_NAME).all():
        raise ValueError("Unknown ability kit ID found")
    if kills.duplicated(
        ["id_killer", "kit_id_killer", "kit_id_victim"]
    ).any():
        raise ValueError("Duplicate kill-stat rows found")
    if abilities.duplicated(["id", "kit_id"]).any():
        raise ValueError("Duplicate ability-use rows found")

    return kills, abilities


def _require_columns(
    frame: pd.DataFrame,
    required: Sequence[str],
    name: str,
) -> None:
    missing = set(required) - set(frame.columns)
    if missing:
        raise ValueError(f"{name} is missing columns: {sorted(missing)}")


def _complete_metric_totals(
    per_player: pd.DataFrame,
    all_kits: pd.DataFrame,
    value_col: str,
) -> pd.DataFrame:
    observed = per_player.groupby(
        ["kit_id", "kit_name"], as_index=False
    )[value_col].sum()
    complete = all_kits.merge(
        observed,
        on=["kit_id", "kit_name"],
        how="left",
    ).fillna({value_col: 0})
    complete[value_col] = complete[value_col].astype(int)
    return complete


def _concentration_from_counts(
    frame: pd.DataFrame,
    *,
    group_col: str,
    value_col: str,
) -> pd.DataFrame:
    rows = []
    for group_value, group in frame.groupby(group_col):
        values = group.loc[group[value_col] > 0, value_col].sort_values(
            ascending=False
        )
        total = values.sum()
        rows.append(
            {
                group_col: group_value,
                "players": int(len(values)),
                "top_player_share": values.iloc[0] / total if total else np.nan,
                "top_3_share": values.iloc[:3].sum() / total if total else np.nan,
            }
        )
    return pd.DataFrame(
        rows,
        columns=[
            group_col,
            "players",
            "top_player_share",
            "top_3_share",
        ],
    )


def _directional_tables(
    matchup_matrix: pd.DataFrame,
) -> tuple[np.ndarray, np.ndarray]:
    counts = matchup_matrix.to_numpy(dtype=int)
    pair_totals = counts + counts.T
    directional_share = np.full(counts.shape, np.nan, dtype=float)
    np.divide(
        counts,
        pair_totals,
        out=directional_share,
        where=pair_totals > 0,
    )
    np.fill_diagonal(directional_share, np.nan)
    np.fill_diagonal(pair_totals, 0)
    return directional_share, pair_totals


def _build_reach(
    player_kit_kills: pd.DataFrame,
    player_kit_abilities: pd.DataFrame,
    n_players: int,
) -> pd.DataFrame:
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
        kill_proportion = players_with_kill / n_players
        ability_proportion = players_with_ability / n_players
    else:
        kill_proportion = players_with_kill.astype(float) * np.nan
        ability_proportion = players_with_ability.astype(float) * np.nan

    return pd.DataFrame(
        {
            "kit_name": KIT_ORDER,
            "used_ability": ability_proportion.to_numpy(),
            "made_kill": kill_proportion.to_numpy(),
            "used_ability_count": players_with_ability.to_numpy(),
            "made_kill_count": players_with_kill.to_numpy(),
        }
    )

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
import plotly.graph_objects as go
from plotly.colors import qualitative


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


def show_player_contribution_figure(fig: go.Figure) -> None:
    """Display a contribution chart with a browser-side player click handler."""

    from IPython.display import HTML, display

    html = fig.to_html(
        full_html=False,
        include_plotlyjs=True,
        post_script=PLAYER_HIGHLIGHT_POST_SCRIPT,
    )
    display(HTML(html))


def concentration_figure(
    stats: pd.DataFrame,
    *,
    total_col: str,
    top_player_col: str,
    top_three_col: str,
    title: str,
    yaxis_title: str,
) -> go.Figure:
    """Build the shared top-player/top-three concentration comparison."""

    plot_data = stats.loc[
        stats[total_col] > 0,
        ["kit_name", top_player_col, top_three_col],
    ].sort_values(top_player_col, ascending=False)

    fig = go.Figure()
    for column, label in (
        (top_player_col, "Top player"),
        (top_three_col, "Top 3 players"),
    ):
        fig.add_trace(
            go.Bar(
                x=plot_data["kit_name"],
                y=plot_data[column],
                name=label,
                hovertemplate=(
                    f"<b>%{{x}}</b><br>{label} share: %{{y:.1%}}"
                    "<extra></extra>"
                ),
            )
        )

    fig.update_layout(
        title=title,
        xaxis_title="Kit",
        yaxis_title=yaxis_title,
        barmode="group",
    )
    fig.update_yaxes(tickformat=".0%", range=[0, 1])
    return fig


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

"""Interactive kill, damage, and Elo matchup heatmaps."""

from __future__ import annotations

from typing import cast

import numpy as np
import pandas as pd
import plotly.graph_objects as go

from .core import KIT_NAMES, KIT_ORDER
from .plot_components import STANDARD_FIGURE_HEIGHT, _trace_count


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
        pair_ids = cast(tuple[float, float], pair)
        cause_lines = []
        for cause_name, kill_value in group[
            ["cause_name", "kills"]
        ].itertuples(index=False, name=None):
            kill_count = int(cast(float, kill_value))
            cause_lines.append(
                f"{cause_name}: {kill_count:,} "
                f"({kill_count / pair_total:.1%})"
            )
        kill_cause_lookup[(int(pair_ids[0]), int(pair_ids[1]))] = (
            "<br>".join(cause_lines)
        )

    for killer_id, killer_name in enumerate(KIT_NAMES):
        for victim_id, victim_name in enumerate(KIT_NAMES):
            kill_count = int(
                cast(float, matchup_matrix.iloc[killer_id, victim_id])
            )
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
                f"{row_kit} kills: "
                f"{int(cast(float, matchup_matrix.iloc[i, j])):,}<br>"
                f"{column_kit} kills: "
                f"{int(cast(float, matchup_matrix.iloc[j, i])):,}<br>"
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
    elo_arrays: tuple[np.ndarray, np.ndarray, np.ndarray] | None = None
    if (
        elo_matchup_expected_share is not None
        and elo_matchup_score_difference is not None
        and elo_matchup_pair_totals is not None
    ):
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
        if np.isfinite(elo_difference).any() and (elo_totals > 0).any():
            elo_arrays = (elo_expected, elo_difference, elo_totals)

    if elo_arrays is not None:
        elo_expected, elo_difference, elo_totals = elo_arrays
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
        elo_trace_index = _trace_count(fig)
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
        assert damage_matchup_matrix is not None
        assert damage_directional_share is not None
        assert damage_pair_totals is not None
        assert matchup_damage_by_cause is not None
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
            pair_ids = cast(tuple[float, float], pair)
            cause_lines = []
            for cause_name, damage_value in group[
                ["cause_name", "damage_received"]
            ].itertuples(index=False, name=None):
                numeric_damage = float(cast(float, damage_value))
                cause_lines.append(
                    f"{cause_name}: {numeric_damage:,.0f} hearts "
                    f"({numeric_damage / pair_total:.1%})"
                )
            damage_cause_lookup[(int(pair_ids[0]), int(pair_ids[1]))] = (
                "<br>".join(cause_lines)
            )

        for source_id, source_name in enumerate(KIT_NAMES):
            for target_id, target_name in enumerate(KIT_NAMES):
                damage_value = float(
                    cast(
                        float,
                        damage_matchup_matrix.iloc[source_id, target_id],
                    )
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

        damage_share_trace_index = _trace_count(fig)
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
        raw_damage_trace_index = _trace_count(fig)
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
            index == trace_index for index in range(_trace_count(fig))
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

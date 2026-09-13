#> sgp.kits:stats_collector/pick_start_preserves_totals
# @dummy
# @environment sgp.ci:stats_collector
#
# Starting a life initializes missing pick counters but never resets accumulated totals on later picks.

data modify storage sgp.kits:stats kits_dict.910005.6.pick set value {total_time:120,nbr_picks:4,last_pick:1,paused_ticks:2}
function sgp.kits:stats_collector/save_pick_start {player_id:910005,kit_id:6,pick_time:500,paused_ticks:30}
assert data storage sgp.kits:stats kits_dict.910005.6.pick{total_time:120,nbr_picks:4,last_pick:500,paused_ticks:30}

function sgp.kits:stats_collector/save_pick_start {player_id:910005,kit_id:6,pick_time:700,paused_ticks:45}
assert data storage sgp.kits:stats kits_dict.910005.6.pick{total_time:120,nbr_picks:4,last_pick:700,paused_ticks:45}

function sgp.kits:stats_collector/save_pick_start {player_id:910006,kit_id:3,pick_time:900,paused_ticks:55}
assert data storage sgp.kits:stats kits_dict.910006.3.pick{total_time:0,nbr_picks:0,last_pick:900,paused_ticks:55}

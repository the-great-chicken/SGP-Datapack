#> sgp.ci:reward_hud/cleanup

function sgp.ci:mixer_lifecycle/cleanup
data remove storage sgp:data markers_lists.location
data modify storage sgp:data markers_lists.location set from storage sgp.ci:reward_hud previous.locations

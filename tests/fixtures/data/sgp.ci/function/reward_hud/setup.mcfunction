#> sgp.ci:reward_hud/setup

function sgp.ci:mixer_lifecycle/setup
data modify storage sgp.ci:reward_hud previous set value {}
data modify storage sgp.ci:reward_hud previous.locations set from storage sgp:data markers_lists.location
data modify storage sgp:data markers_lists.location set value []

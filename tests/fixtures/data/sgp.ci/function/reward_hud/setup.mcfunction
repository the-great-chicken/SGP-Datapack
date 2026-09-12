#> sgp.ci:reward_hud/setup
# Snapshot mixer state and the production reward-marker list, then isolate that list for the test.

function sgp.ci:actionbar_mixer/setup
data modify storage sgp.ci:reward_hud previous set value {}
data modify storage sgp.ci:reward_hud previous.locations set from storage sgp:data markers_lists.location
data modify storage sgp:data markers_lists.location set value []

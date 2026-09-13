#> sgp.ci:reward_hud/cleanup
# Restore actionbar mixer state and the production reward-marker list saved by setup.

function sgp.ci:actionbar_mixer/cleanup
data remove storage sgp:data markers_lists.location
data modify storage sgp:data markers_lists.location set from storage sgp.ci:reward_hud previous.locations

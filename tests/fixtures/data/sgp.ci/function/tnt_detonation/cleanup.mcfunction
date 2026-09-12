#> sgp.ci:tnt_detonation/cleanup
# Remove lingering-fire results and the shared TNT charge/interaction pairs.

kill @e[tag=sgp.ci.detonation_fire,type=marker]
function sgp.ci:tnt/interaction_pairs/clear
function sgp.ci:players/cleanup

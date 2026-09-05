#> sgp.majeurs:pco/cage/capture
# `{team}`
#
# Finish a deferred capture only if the player still belongs to the active round.

execute unless score #pco_phase sgp.dummy matches 2 run return 0
$execute unless entity @s[tag=sgp.major_participant,team=sgp.$(team)] run return 0
$tp @s @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_spawn_cage_$(team)",limit=1,type=marker]
tag @s remove sgp.pco.awaiting_cage

#> sgp.kits:repulsion/facing
# @dummy
# @environment sgp.ci:repulsion/facing
#
# Turning west makes the backward impulse point east.

gamemode spectator @s
tp @s 8.0 136.0 8.0
await entity @s[predicate=sgp.ci:repulsion/area_loaded]
execute positioned 0.0 128.0 0.0 run function sgp.ci:repulsion/fixture
function sgp.ci:repulsion/tick_probe
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]

execute positioned 0.0 128.0 0.0 run function sgp.ci:repulsion/scenarios/facing/1
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
execute positioned 0.0 128.0 0.0 run function sgp.ci:repulsion/scenarios/facing/2

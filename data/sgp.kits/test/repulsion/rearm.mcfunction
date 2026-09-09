#> sgp.kits:repulsion/rearm
# @dummy
# @environment sgp.ci:repulsion/rearm
#
# The wearer can trigger another impulse after the first trigger has been consumed.

gamemode spectator @s
tp @s 8.0 96.0 8.0
await entity @s[predicate=sgp.ci:repulsion/area_loaded]
execute positioned 0.0 88.0 0.0 run function sgp.ci:repulsion/fixture
function sgp.ci:repulsion/tick_probe
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]

execute positioned 0.0 88.0 0.0 run function sgp.ci:repulsion/scenarios/rearm/1
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
execute positioned 0.0 88.0 0.0 run function sgp.ci:repulsion/scenarios/rearm/2
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
execute positioned 0.0 88.0 0.0 run function sgp.ci:repulsion/scenarios/rearm/3

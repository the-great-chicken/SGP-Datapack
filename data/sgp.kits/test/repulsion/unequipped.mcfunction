#> sgp.kits:repulsion/unequipped
# @dummy
# @environment sgp.ci:repulsion/unequipped
#
# A trigger without enchanted equipment produces no impulse.

gamemode spectator @s
tp @s 8.0 136.0 8.0
await entity @s[predicate=sgp.ci:repulsion/area_loaded]
execute positioned 0.0 128.0 0.0 run function sgp.ci:repulsion/fixture
function sgp.ci:repulsion/tick_probe
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]

execute positioned 0.0 128.0 0.0 run function sgp.ci:repulsion/scenarios/unequipped/1
await delay 3t
execute positioned 0.0 128.0 0.0 run function sgp.ci:repulsion/scenarios/unequipped/2

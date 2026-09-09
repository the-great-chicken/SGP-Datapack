#> sgp.kits:rays/damage_water
# @dummy
# @environment sgp.ci:rays/damage_water
#
# Water does not shield a target, but the solid wall behind the first target still shields the second.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
await delay 61t
function sgp.ci:rays/scenarios/damage_water

#> sgp.kits:rays/damage_off_axis
# @dummy
# @environment sgp.ci:rays/damage_off_axis
#
# A player between the eight beams remains safe beside a player on the beam.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
await delay 61t
function sgp.ci:rays/scenarios/damage_off_axis

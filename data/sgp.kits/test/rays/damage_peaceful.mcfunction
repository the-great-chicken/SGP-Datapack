#> sgp.kits:rays/damage_peaceful
# @dummy
# @environment sgp.ci:rays/damage_peaceful
#
# A peaceful player remains unharmed without shielding another player farther along the beam.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
await delay 61t
function sgp.ci:rays/prepare_damage
tag RayNear add sgp.peaceful
function sgp.ci:rays/update
execute unless entity @a[name=RayNear,nbt={Health:20.0f}] run function sgp.ci:rays/damage_diagnostics
execute unless entity @a[name=RayFar,nbt={Health:19.75f}] run function sgp.ci:rays/damage_diagnostics
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 20000
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19750
assert entity @s[nbt={Health:20.0f}]

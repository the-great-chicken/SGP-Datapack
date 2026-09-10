#> sgp.kits:rays/damage_stale_ids_peaceful
# @dummy
# @environment sgp.ci:rays/damage_stale_ids_peaceful
#
# Stale IDs from previous raycasts must not redirect damage between players.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
await delay 61t
function sgp.ci:rays/prepare_damage
# Reproduce IDs retained across casts or a returning player's session.
scoreboard players set RayNear bs.raycast.id 1
scoreboard players set RayFar bs.raycast.id 1
tag RayNear add sgp.peaceful
function sgp.ci:rays/update
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 20000
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19750
assert entity @s[nbt={Health:20.0f}]

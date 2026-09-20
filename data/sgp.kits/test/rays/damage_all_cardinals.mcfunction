#> sgp.kits:rays/damage_all_cardinals
# @dummy
# @environment sgp.ci:rays/damage_all_cardinals
#
# Every clear cardinal beam damages a target standing mid-range on its line, in both directions of both axes.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
await delay 61t
function sgp.ci:rays/prepare_damage
# West and north beams.
tp RayNear 3.5 88.0 8.5
tp RayFar 8.5 88.0 3.5
function sgp.ci:rays/update
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19750
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19750
# East and south beams.
tp RayNear 13.5 88.0 8.5
tp RayFar 8.5 88.0 13.5
function sgp.ci:rays/update
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19500
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19500
assert entity @s[nbt={Health:20.0f}]

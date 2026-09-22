#> sgp.kits:rays/spectator_untouched
# @dummy
# @environment sgp.ci:rays/spectator_untouched
#
# Spectators on a beam line are never Rays targets: not tagged, not hitbox-cached, not flashed.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
await delay 61t
function sgp.ci:rays/prepare_damage
gamemode spectator RayNear
function sgp.ci:rays/update
assert not entity @a[name=RayNear,tag=sgp.ray_hitbox_cached]
assert not score RayNear bs.width matches -2147483648..2147483647
assert entity @a[name=RayNear,nbt={Health:20.0f}]
assert entity @a[name=RayFar,tag=sgp.ray_hitbox_cached]
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19750

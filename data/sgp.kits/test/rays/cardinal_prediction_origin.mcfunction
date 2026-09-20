#> sgp.kits:rays/cardinal_prediction_origin
# @dummy
# @environment sgp.ci:rays/cardinal_prediction_origin
#
# Clear cardinal beams measure hits from the collision origin, not from the visually predicted display position.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
await delay 61t
function sgp.ci:rays/prepare_damage
tp RayNear 8.5 88.0 9.4
tp RayFar 8.5 88.0 -7.6
# Two-tick horizontal prediction: a 0.4-block delta becomes a +0.8 display offset along +z without moving the caster.
scoreboard players remove @s sgp.old_z 400
function sgp.ci:rays/update
execute positioned 8.5 88.6 9.3 store result score #ci.rays.moved sgp.dummy if entity @e[tag=sgp.ray,distance=..0.01,type=item_display]
assert score #ci.rays.moved sgp.dummy matches 8
# Leading (south) beam: entry 0.6 from the origin, -0.2 from the predicted position.
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19750
# Trailing (north) beam: entry 15.8 from the origin, 16.6 from the predicted position.
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19750
assert entity @s[nbt={Health:20.0f}]

# Same geometry and prediction through the general DDA path: a blocker at ^ ^ ^16 defeats cardinal_clear on the leading beam only.
setblock 8 88 24 stone
scoreboard players remove @s sgp.old_z 400
function sgp.ci:rays/update
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19500
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19500

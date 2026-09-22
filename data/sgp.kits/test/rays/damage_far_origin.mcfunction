#> sgp.kits:rays/damage_far_origin
# @dummy
# @environment sgp.ci:rays_far/damage_far_origin
#
# Clear cardinal beams still damage targets in arenas far from the world origin, where absolute fixed-point positions overflow.

gamemode spectator @s
tp @s 1008.0 88.0 1008.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:rays_far/ready
await entity @e[tag=sgp.ci.far_ready,x=1008,y=88,z=1008,distance=..1,type=marker]
kill @e[tag=sgp.ci.far_ready,type=marker]
function sgp.ci:rays_far/damage_roster
await delay 61t
function sgp.ci:rays_far/prepare_damage
function sgp.ci:rays/update
# South beam, entry 1.7 blocks from the origin.
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19750
# East beam, entry 15.8 blocks from the origin.
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19750
assert entity @s[nbt={Health:20.0f}]

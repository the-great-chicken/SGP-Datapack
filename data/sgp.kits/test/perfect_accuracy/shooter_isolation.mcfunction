#> sgp.kits:perfect_accuracy/shooter_isolation
# @dummy
# @environment sgp.ci:perfect_accuracy/shooter_isolation
#
# Correction uses the projectile's owner, regardless of the caller's position and rotation, and leaves other projectiles alone.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:perfect_accuracy/scenarios/shooter_isolation

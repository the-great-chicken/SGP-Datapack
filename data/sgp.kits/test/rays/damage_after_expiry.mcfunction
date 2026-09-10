#> sgp.kits:rays/damage_after_expiry
# @dummy
# @environment sgp.ci:rays/damage_after_expiry
#
# Expiring the ray ability removes its beams without damaging nearby targets.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
await delay 61t
function sgp.ci:rays/prepare_damage
scoreboard players set @s sgp.duration_ability 1
function sgp.ci:rays/update
function sgp.ci:rays/count {count:0}
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 20000
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 20000

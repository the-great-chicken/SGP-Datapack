#> sgp.kits:rays/players_only
# @dummy
# @environment sgp.ci:rays/damage_stale_ids
# Non-player hitboxes and their raycast IDs are untouched; stale player IDs cannot redirect damage.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
await delay 61t
function sgp.ci:rays/prepare_damage
summon armor_stand 8.5 88.0 11.5 {Tags:["sgp.ci.ray_nonplayer"],NoGravity:1b}
execute positioned 8.5 88.0 11.5 run scoreboard players set @e[tag=sgp.ci.ray_nonplayer,distance=..1,type=armor_stand] bs.raycast.id 777
scoreboard players set RayNear bs.raycast.id 1
scoreboard players set RayFar bs.raycast.id 1
function sgp.ci:rays/update
execute positioned 8.5 88.0 11.5 run assert entity @e[tag=sgp.ci.ray_nonplayer,tag=!bs.raycast.checked,scores={bs.raycast.id=777},nbt={Health:20.0f},distance=..1,type=armor_stand]
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19750
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19750
assert entity @s[nbt={Health:20.0f}]

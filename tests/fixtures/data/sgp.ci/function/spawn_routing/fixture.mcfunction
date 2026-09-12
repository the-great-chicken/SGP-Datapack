#> sgp.ci:spawn_routing/fixture
# Distinct normal destinations and event spawns so routing mistakes cannot pass accidentally.

execute as @a[tag=sgp.ci.spawn_actor] run dummy @s leave
kill @e[tag=sgp.ci.spawn_routing,type=marker]
scoreboard players set #confines_secondes sgp.timer 0
scoreboard players set #protect_phase sgp.dummy 0
tag @s add sgp.ci.spawn_actor
gamemode creative @s
fill ~ ~1 ~ ~24 ~4 ~4 air
fill ~ ~ ~ ~24 ~ ~4 stone
tp @s ~0.5 ~1 ~0.5
summon marker ~4.25 ~1 ~0.75 {Tags:["sgp.ci.spawn_routing","sgp.ci.spawn_destination","sgp.ci.spawn_first"],data:{yaw:90,pitch:15}}
summon marker ~8.75 ~1 ~0.25 {Tags:["sgp.ci.spawn_routing","sgp.ci.spawn_destination","sgp.ci.spawn_second"],data:{yaw:-90,pitch:-30}}
summon marker ~16.5 ~1 ~0.5 {CustomName:"Confinement",Tags:["sgp.marker","sgp.ci.spawn_routing"]}
summon marker ~20.5 ~1 ~0.5 {CustomName:"protect_spawn_rouges",Tags:["sgp.marker","sgp.ci.spawn_routing"]}
summon marker ~22.5 ~1 ~0.5 {CustomName:"protect_spawn_bleus",Tags:["sgp.marker","sgp.ci.spawn_routing"]}
data modify storage sgp.ci:spawn_routing normal set value {spawns:[]}
execute as @e[tag=sgp.ci.spawn_first,distance=..32,limit=1,type=marker] run function sgp.ci:spawn_routing/append_destination
execute as @e[tag=sgp.ci.spawn_second,distance=..32,limit=1,type=marker] run function sgp.ci:spawn_routing/append_destination
data modify storage sgp.ci:spawn_routing first set value {spawns:[]}
data modify storage sgp.ci:spawn_routing first.spawns append from storage sgp.ci:spawn_routing normal.spawns[0]
data modify storage sgp.ci:spawn_routing second set value {spawns:[]}
data modify storage sgp.ci:spawn_routing second.spawns append from storage sgp.ci:spawn_routing normal.spawns[1]

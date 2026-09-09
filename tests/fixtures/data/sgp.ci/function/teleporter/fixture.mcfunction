#> sgp.ci:teleporter/fixture

kill @e[tag=sgp.ci.teleporter,type=marker]
fill ~ ~ ~ ~24 ~ ~6 stone
fill ~ ~1 ~ ~24 ~5 ~6 air
gamemode creative @s
scoreboard players set @s sgp.teleporteur 0
tp @s ~2.5 ~1 ~2.5
summon marker ~2.5 ~1 ~2.5 {Tags:["sgp.ci.teleporter","sgp.ci.portal_a"],data:{yaw:90,pitch:15}}
summon marker ~14.5 ~1 ~2.5 {Tags:["sgp.ci.teleporter","sgp.ci.portal_b"],data:{yaw:-90,pitch:-30}}
summon marker ~8.25 ~1 ~0.75 {Tags:["sgp.ci.teleporter","sgp.ci.destination_a"]}
summon marker ~20.75 ~1 ~0.25 {Tags:["sgp.ci.teleporter","sgp.ci.destination_b"]}
data modify storage sgp:data tests.teleporter.sources set value []
data modify entity @n[tag=sgp.ci.portal_a,type=marker] data.x set from entity @n[tag=sgp.ci.destination_a,type=marker] Pos[0]
data modify entity @n[tag=sgp.ci.portal_a,type=marker] data.y set from entity @n[tag=sgp.ci.destination_a,type=marker] Pos[1]
data modify entity @n[tag=sgp.ci.portal_a,type=marker] data.z set from entity @n[tag=sgp.ci.destination_a,type=marker] Pos[2]
execute as @n[tag=sgp.ci.portal_a,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"tests.teleporter.sources"}
data modify entity @n[tag=sgp.ci.portal_b,type=marker] data.x set from entity @n[tag=sgp.ci.destination_b,type=marker] Pos[0]
data modify entity @n[tag=sgp.ci.portal_b,type=marker] data.y set from entity @n[tag=sgp.ci.destination_b,type=marker] Pos[1]
data modify entity @n[tag=sgp.ci.portal_b,type=marker] data.z set from entity @n[tag=sgp.ci.destination_b,type=marker] Pos[2]
execute as @n[tag=sgp.ci.portal_b,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"tests.teleporter.sources"}

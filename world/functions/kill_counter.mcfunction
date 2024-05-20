execute if data storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] store result score #counter_increment_array dummy run data get storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0]
execute if score #counter_increment_array dummy matches 0 run data modify storage minecraft:kill_counter HandItems[0].tag.increment set from storage minecraft:kill_counter HandItems[0].tag.KillArray[0]
execute if score #counter_increment_array dummy matches 0 store result score #increment dummy run data get storage minecraft:kill_counter HandItems[0].tag.increment
execute if score #counter_increment_array dummy matches 0 run scoreboard players operation #increment dummy += 1 dummy
execute if score #counter_increment_array dummy matches 0 store result storage minecraft:kill_counter HandItems[0].tag.increment int 1 run scoreboard players get #increment dummy
execute if score #counter_increment_array dummy matches 0 run data modify storage minecraft:kill_counter HandItems[0].tag.KillArray[0] set from storage minecraft:kill_counter HandItems[0].tag.increment
execute if data storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] run data modify storage minecraft:kill_counter HandItems[0].tag.KillArrayCopy append from storage minecraft:kill_counter HandItems[0].tag.KillArray[0]
execute if data storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] run data remove storage minecraft:kill_counter HandItems[0].tag.KillArray[0]
execute if data storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] run scoreboard players operation #counter_increment_array dummy -= 1 dummy
execute if data storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] store result storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] int 1 run scoreboard players get #counter_increment_array dummy
execute unless data storage minecraft:kill_counter HandItems[0].tag.KillArray[0] run data modify storage minecraft:kill_counter HandItems[0].tag.reset set value 1b
execute if data storage minecraft:kill_counter HandItems[0].tag.reset run data modify storage minecraft:kill_counter HandItems[0].tag.KillArray set from storage minecraft:kill_counter HandItems[0].tag.KillArrayCopy
execute if data storage minecraft:kill_counter HandItems[0].tag.reset run data modify storage minecraft:kill_counter HandItems[0].tag.KillArrayCopy set value []
execute if data storage minecraft:kill_counter HandItems[0].tag.reset run data remove storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0]
execute if data storage minecraft:kill_counter HandItems[0].tag.reset run data remove storage minecraft:kill_counter HandItems[0].tag.reset

execute as @a if score @s last_kill_count >= 1 dummy run execute store result score #kit_id_tueur dummy run scoreboard players get @s kit_id
execute as @a if score @s last_kill_count >= 1 dummy run scoreboard players set @s last_kill_count 0

execute if score #kit_id_victime dummy >= 0 dummy run execute if score #kit_id_tueur dummy >= 0 dummy run scoreboard players set #kit_id_kill_run dummy 1
execute if score #kit_id_kill_run dummy matches 1 store result storage minecraft:kill_counter HandItems[0].tag.provKillTueur int 1 run scoreboard players get #kit_id_tueur dummy
execute if score #kit_id_kill_run dummy matches 1 store result storage minecraft:kill_counter HandItems[0].tag.provKillVictime int 1 run scoreboard players get #kit_id_victime dummy
execute if score #kit_id_kill_run dummy matches 1 run scoreboard players operation #kit_id_tueur dummy *= 12 dummy
execute if score #kit_id_kill_run dummy matches 1 run scoreboard players operation #kit_id_tueur dummy += #kit_id_victime dummy
execute if score #kit_id_kill_run dummy matches 1 store result storage minecraft:kill_counter HandItems[0].tag.provKillUpdate int 1 run scoreboard players get #kit_id_tueur dummy
execute if score #kit_id_kill_run dummy matches 1 run data modify storage minecraft:kill_counter HandItems[0].tag.KillUpdates append from storage minecraft:kill_counter HandItems[0].tag.provKillUpdate
scoreboard players set #kit_id_victime dummy -1
execute if score #kit_id_kill_run dummy matches 1 run scoreboard players set #kit_id_tueur dummy -1
execute if score #kit_id_kill_run dummy matches 1 run scoreboard players set #kit_id_kill_run dummy 0
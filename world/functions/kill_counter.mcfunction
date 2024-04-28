execute if data storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] store result score #counter_increment_array test run data get storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0]
execute if score #counter_increment_array test matches 0 run data modify storage minecraft:kill_counter HandItems[0].tag.increment set from storage minecraft:kill_counter HandItems[0].tag.KillArray[0]
execute if score #counter_increment_array test matches 0 store result score #increment test run data get storage minecraft:kill_counter HandItems[0].tag.increment
execute if score #counter_increment_array test matches 0 run scoreboard players operation #increment test += 1 test
execute if score #counter_increment_array test matches 0 store result storage minecraft:kill_counter HandItems[0].tag.increment int 1 run scoreboard players get #increment test
execute if score #counter_increment_array test matches 0 run data modify storage minecraft:kill_counter HandItems[0].tag.KillArray[0] set from storage minecraft:kill_counter HandItems[0].tag.increment
execute if data storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] run data modify storage minecraft:kill_counter HandItems[0].tag.KillArrayCopy append from storage minecraft:kill_counter HandItems[0].tag.KillArray[0]
execute if data storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] run data remove storage minecraft:kill_counter HandItems[0].tag.KillArray[0]
execute if data storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] run scoreboard players operation #counter_increment_array test -= 1 test
execute if data storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] store result storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0] int 1 run scoreboard players get #counter_increment_array test
execute unless data storage minecraft:kill_counter HandItems[0].tag.KillArray[0] run data modify storage minecraft:kill_counter HandItems[0].tag.reset set value 1b
execute if data storage minecraft:kill_counter HandItems[0].tag.reset run data modify storage minecraft:kill_counter HandItems[0].tag.KillArray set from storage minecraft:kill_counter HandItems[0].tag.KillArrayCopy
execute if data storage minecraft:kill_counter HandItems[0].tag.reset run data modify storage minecraft:kill_counter HandItems[0].tag.KillArrayCopy set value []
execute if data storage minecraft:kill_counter HandItems[0].tag.reset run data remove storage minecraft:kill_counter HandItems[0].tag.KillUpdates[0]
execute if data storage minecraft:kill_counter HandItems[0].tag.reset run data remove storage minecraft:kill_counter HandItems[0].tag.reset

execute as @a if score @s last_kill_count >= 1 test run execute store result score #kit_id_tueur test run scoreboard players get @s kit_id
execute as @a if score @s last_kill_count >= 1 test run scoreboard players set @s last_kill_count 0

execute if score #kit_id_victime test >= 0 test run execute if score #kit_id_tueur test >= 0 test run scoreboard players set #kit_id_kill_run test 1
execute if score #kit_id_kill_run test matches 1 store result storage minecraft:kill_counter HandItems[0].tag.provKillTueur int 1 run scoreboard players get #kit_id_tueur test
execute if score #kit_id_kill_run test matches 1 store result storage minecraft:kill_counter HandItems[0].tag.provKillVictime int 1 run scoreboard players get #kit_id_victime test
execute if score #kit_id_kill_run test matches 1 run scoreboard players operation #kit_id_tueur test *= 12 test
execute if score #kit_id_kill_run test matches 1 run scoreboard players operation #kit_id_tueur test += #kit_id_victime test
execute if score #kit_id_kill_run test matches 1 store result storage minecraft:kill_counter HandItems[0].tag.provKillUpdate int 1 run scoreboard players get #kit_id_tueur test
execute if score #kit_id_kill_run test matches 1 run data modify storage minecraft:kill_counter HandItems[0].tag.KillUpdates append from storage minecraft:kill_counter HandItems[0].tag.provKillUpdate
execute if score #kit_id_kill_run test matches 1 run scoreboard players set #kit_id_victime test -1
execute if score #kit_id_kill_run test matches 1 run scoreboard players set #kit_id_tueur test -1
execute if score #kit_id_kill_run test matches 1 run scoreboard players set #kit_id_kill_run test 0
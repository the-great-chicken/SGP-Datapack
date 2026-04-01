#> sgp.misc:kill_counter
# 
# Manage an array that counts kills from each kit on every other

execute if data storage sgp:kill_counter KillUpdates[0] store result score #counter_increment_array sgp.dummy run data get storage sgp:kill_counter KillUpdates[0]
execute if score #counter_increment_array sgp.dummy matches 0 run data modify storage sgp:kill_counter increment set from storage sgp:kill_counter KillArray[0]
execute if score #counter_increment_array sgp.dummy matches 0 store result score #increment sgp.dummy run data get storage sgp:kill_counter increment
execute if score #counter_increment_array sgp.dummy matches 0 run scoreboard players operation #increment sgp.dummy += 1 sgp.dummy
execute if score #counter_increment_array sgp.dummy matches 0 store result storage sgp:kill_counter increment int 1 run scoreboard players get #increment sgp.dummy
execute if score #counter_increment_array sgp.dummy matches 0 run data modify storage sgp:kill_counter KillArray[0] set from storage sgp:kill_counter increment
execute if data storage sgp:kill_counter KillUpdates[0] run data modify storage sgp:kill_counter KillArrayCopy append from storage sgp:kill_counter KillArray[0]
execute if data storage sgp:kill_counter KillUpdates[0] run data remove storage sgp:kill_counter KillArray[0]
execute if data storage sgp:kill_counter KillUpdates[0] run scoreboard players operation #counter_increment_array sgp.dummy -= 1 sgp.dummy
execute if data storage sgp:kill_counter KillUpdates[0] store result storage sgp:kill_counter KillUpdates[0] int 1 run scoreboard players get #counter_increment_array sgp.dummy
execute unless data storage sgp:kill_counter KillArray[0] run data modify storage sgp:kill_counter reset set value 1b
execute if data storage sgp:kill_counter reset run data modify storage sgp:kill_counter KillArray set from storage sgp:kill_counter KillArrayCopy
execute if data storage sgp:kill_counter reset run data modify storage sgp:kill_counter KillArrayCopy set value []
execute if data storage sgp:kill_counter reset run data remove storage sgp:kill_counter KillUpdates[0]
execute if data storage sgp:kill_counter reset run data remove storage sgp:kill_counter reset

execute as @a[tag=sgp.in_game] if score @s sgp.last_kill_count matches 1.. run execute store result score #kit_id_tueur sgp.dummy run scoreboard players get @s sgp.kit_id
execute as @a[tag=sgp.in_game] if score @s sgp.last_kill_count matches 1.. run scoreboard players set @s sgp.last_kill_count 0

execute if score #kit_id_victime sgp.dummy matches 0.. run execute if score #kit_id_tueur sgp.dummy matches 0.. run scoreboard players set #kit_id_kill_run sgp.dummy 1
execute if score #kit_id_kill_run sgp.dummy matches 1 store result storage sgp:kill_counter provKillTueur int 1 run scoreboard players get #kit_id_tueur sgp.dummy
execute if score #kit_id_kill_run sgp.dummy matches 1 store result storage sgp:kill_counter provKillVictime int 1 run scoreboard players get #kit_id_victime sgp.dummy
execute if score #kit_id_kill_run sgp.dummy matches 1 run scoreboard players operation #kit_id_tueur sgp.dummy *= 12 sgp.dummy
execute if score #kit_id_kill_run sgp.dummy matches 1 run scoreboard players operation #kit_id_tueur sgp.dummy += #kit_id_victime sgp.dummy
execute if score #kit_id_kill_run sgp.dummy matches 1 store result storage sgp:kill_counter provKillUpdate int 1 run scoreboard players get #kit_id_tueur sgp.dummy
execute if score #kit_id_kill_run sgp.dummy matches 1 run data modify storage sgp:kill_counter KillUpdates append from storage sgp:kill_counter provKillUpdate
scoreboard players set #kit_id_victime sgp.dummy -1
execute if score #kit_id_kill_run sgp.dummy matches 1 run scoreboard players set #kit_id_tueur sgp.dummy -1
execute if score #kit_id_kill_run sgp.dummy matches 1 run scoreboard players set #kit_id_kill_run sgp.dummy 0
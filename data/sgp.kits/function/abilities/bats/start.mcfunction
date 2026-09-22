#> sgp.kits:abilities/bats/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.bats.cooldown
execute store result score @s sgp.duration_ability run data get storage sgp:data kits.ability_cooldowns.bats.duration
function sgp.kits:stats_collector/ability/start {kit_id:10,ability_path:"bats"}


execute store result score #backup_duration sgp.dummy run data get storage sgp:data kits.ability_cooldowns.bats.duration
scoreboard players operation #seconds_duration sgp.dummy = #backup_duration sgp.dummy
scoreboard players operation #seconds_duration sgp.dummy /= 20 sgp.dummy
scoreboard players operation #damage_owner sgp.dummy = @s sgp.id
scoreboard players operation #bat_ability_cast sgp.dummy = @s sgp.ability_cast
execute store result score #bat_arm_at sgp.dummy run time query gametime
scoreboard players add #bat_arm_at sgp.dummy 20
execute store result storage sgp:data kits.ability_cooldowns.bats.duration short 1 run scoreboard players get #seconds_duration sgp.dummy
function sgp.kits:abilities/bats/invisible_for_time with storage sgp:data kits.ability_cooldowns.bats
execute store result storage sgp:data kits.ability_cooldowns.bats.duration short 1 run scoreboard players get #backup_duration sgp.dummy

tag @s add sgp.processing

execute summon armor_stand run function sgp.kits:abilities/bats/hide/equipment

tag @s remove sgp.processing

# Each cast gets an exact +1s wake. The wake only scans bats whose own arm timestamp has elapsed, then feeds one shared 8-tick follow-up loop.
schedule function sgp.kits:abilities/bats/check_for_explosion 1s append

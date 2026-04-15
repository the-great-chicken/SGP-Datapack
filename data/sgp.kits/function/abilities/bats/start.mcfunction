#> sgp.kits:abilities/bats/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.bats.cooldown
execute store result score @s sgp.duration_ability run data get storage sgp:data kits.ability_cooldowns.bats.duration


execute store result score #backup_duration sgp.dummy run data get storage sgp:data kits.ability_cooldowns.bats.duration
scoreboard players operation #seconds_duration sgp.dummy = #backup_duration sgp.dummy
scoreboard players operation #seconds_duration sgp.dummy /= 20 sgp.dummy
execute store result storage sgp:data kits.ability_cooldowns.bats.duration short 1 run scoreboard players get #seconds_duration sgp.dummy
function sgp.kits:abilities/bats/invisible_for_time with storage sgp:data kits.ability_cooldowns.bats
execute store result storage sgp:data kits.ability_cooldowns.bats.duration short 1 run scoreboard players get #backup_duration sgp.dummy

tag @s add sgp.processing

execute summon armor_stand run function sgp.kits:abilities/bats/hide/equipment

tag @s remove sgp.processing

# Bats can only detonate after 1s (although if another cancer casted the ability earlier, the explosion check will already be running)
# And I'm too lazy to fix this concurrency bug, it doesn't really matter
schedule function sgp.kits:abilities/bats/check_for_explosion 1s append
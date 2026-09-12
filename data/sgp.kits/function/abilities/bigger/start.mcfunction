#> sgp.kits:abilities/bigger/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.bigger.cooldown
execute store result score @s sgp.duration_ability run data get storage sgp:data kits.ability_cooldowns.bigger.duration
function sgp.kits:stats_collector/ability/start {kit_id:5,ability_path:"bigger"}
tag @s add sgp.stats_tank_boost_active

function sgp.kits:abilities/bigger/apply

playsound entity.mooshroom.convert master @a ~ ~ ~ 1 1
particle poof ~ ~2 ~ 0 1 0 0.4 100 force @a

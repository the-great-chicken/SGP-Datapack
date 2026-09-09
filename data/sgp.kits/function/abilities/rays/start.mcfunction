#> sgp.kits:abilities/rays/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.rays.cooldown
execute store result score @s sgp.duration_ability run data get storage sgp:data kits.ability_cooldowns.rays.duration
function sgp.kits:stats_collector/ability/start {kit_id:6,ability_path:"rays"}

function sgp.kits:abilities/rays/init

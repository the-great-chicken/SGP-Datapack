#> sgp.kits:stats_collector/ability/mark_success
# `{kit_id: int, ability_path: string}`

execute if score @s sgp.ability_success matches 1 run return 0

scoreboard players set @s sgp.ability_success 1
$function sgp.kits:stats_collector/ability/increment {kit_id:$(kit_id),ability_path:"$(ability_path)",metric:"successful_uses",amount:1}

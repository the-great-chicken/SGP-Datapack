#> sgp.kits:stats_collector/ability/start
# `{kit_id: int, ability_path: string}`
#
# Opens a new cast and records one real activation. Abilities whose trigger may
# fail (currently Pecking) call this only after their own validation succeeds.

execute unless function sgp.kits:stats_collector/can_collect run return 0

scoreboard players add #next_ability_cast sgp.dummy 1
scoreboard players operation @s sgp.ability_cast = #next_ability_cast sgp.dummy
$scoreboard players set @s sgp.ability_kind $(kit_id)
scoreboard players set @s sgp.ability_success 0
execute store result storage sgp:macro stats.affected.id int 1 run scoreboard players get @s sgp.id
function sgp.kits:stats_collector/ability/clear_affected with storage sgp:macro stats.affected

$function sgp.kits:stats_collector/ability/increment {kit_id:$(kit_id),ability_path:"$(ability_path)",metric:"uses",amount:1}

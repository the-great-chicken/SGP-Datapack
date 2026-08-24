#> sgp.kits:stats_collector/ability/mark_affected
# `{kit_id: int, ability_path: string}`
#
# Executed as the caster while the damaged player has sgp.ability_damage_target.
# A global cast id makes the victim count at most once for this cast, including
# abilities whose damage repeats over several ticks.

execute unless entity @a[tag=sgp.ability_damage_target,tag=sgp.in_game,tag=!sgp.peaceful,limit=1] run return 0
execute if score @a[tag=sgp.ability_damage_target,limit=1] sgp.id = @s sgp.id run return 0
execute if score @a[tag=sgp.ability_damage_target,limit=1] sgp.last_ability_cast = @s sgp.ability_cast run return 0

scoreboard players operation @a[tag=sgp.ability_damage_target,limit=1] sgp.last_ability_cast = @s sgp.ability_cast
$function sgp.kits:stats_collector/ability/mark_success {kit_id:$(kit_id),ability_path:"$(ability_path)"}
$function sgp.kits:stats_collector/ability/increment {kit_id:$(kit_id),ability_path:"$(ability_path)",metric:"affected_players",amount:1}

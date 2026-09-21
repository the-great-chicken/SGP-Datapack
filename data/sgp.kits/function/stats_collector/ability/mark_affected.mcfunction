#> sgp.kits:stats_collector/ability/mark_affected
# `{kit_id: int, ability_path: string}`
#
# Executed as the caster while the damaged player has sgp.ability_damage_target.
# A per-caster tag on the victim counts it at most once per cast, including abilities whose
# damage repeats over several ticks and casts interleaved with other casters' hits.
execute store result storage sgp:macro stats.affected.id int 1 run scoreboard players get @s sgp.id
execute store result score #affected_new sgp.dummy run function sgp.kits:stats_collector/ability/tag_affected with storage sgp:macro stats.affected
execute unless score #affected_new sgp.dummy matches 1 run return 0
$function sgp.kits:stats_collector/ability/mark_success {kit_id:$(kit_id),ability_path:"$(ability_path)"}
$function sgp.kits:stats_collector/ability/increment {kit_id:$(kit_id),ability_path:"$(ability_path)",metric:"affected_players",amount:1}

#> sgp.kits:stats_collector/ability/mark_ray_affected
#
# Executed as a player damaged by Rays. #ray_ability_cast belongs to the caster.

execute if score @s sgp.last_ability_cast = #ray_ability_cast sgp.dummy run return 0

scoreboard players operation @s sgp.last_ability_cast = #ray_ability_cast sgp.dummy
execute on attacker run function sgp.kits:stats_collector/ability/mark_success {kit_id:6,ability_path:"rays"}
execute on attacker run function sgp.kits:stats_collector/ability/increment {kit_id:6,ability_path:"rays",metric:"affected_players",amount:1}

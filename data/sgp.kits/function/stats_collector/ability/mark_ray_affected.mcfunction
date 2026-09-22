#> sgp.kits:stats_collector/ability/mark_ray_affected
# `{id_source: int}`: the caster's player id.
#
# Executed as a player damaged by Rays; #ray_ability_cast belongs to the caster. A per-caster
# tag on the victim counts it once per cast even when other casters hit the same victim in
# between (a single victim-side cast id did not, and over-counted affected_players).
# The caster's next ability/start clears its tags.
$execute if entity @s[tag=sgp.ability_affected.$(id_source)] run return 0
$tag @s add sgp.ability_affected.$(id_source)
execute on attacker run function sgp.kits:stats_collector/ability/mark_success {kit_id:6,ability_path:"rays"}
execute on attacker run function sgp.kits:stats_collector/ability/increment {kit_id:6,ability_path:"rays",metric:"affected_players",amount:1}

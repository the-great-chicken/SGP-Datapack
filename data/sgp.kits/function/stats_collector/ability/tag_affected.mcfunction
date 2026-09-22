#> sgp.kits:stats_collector/ability/tag_affected
# `{id: int}`: the caster's player id. Tags the damaged player for this caster; returns 1 only the first time.
$execute if entity @a[tag=sgp.ability_damage_target,tag=sgp.ability_affected.$(id),limit=1] run return 0
$tag @a[tag=sgp.ability_damage_target,limit=1] add sgp.ability_affected.$(id)
return 1

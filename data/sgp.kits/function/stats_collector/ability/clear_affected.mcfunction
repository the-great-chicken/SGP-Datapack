#> sgp.kits:stats_collector/ability/clear_affected
# `{id: int}`: the caster's player id. A new cast may count every victim again.
$tag @a remove sgp.ability_affected.$(id)

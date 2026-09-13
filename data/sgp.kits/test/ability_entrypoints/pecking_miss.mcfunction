#> sgp.kits:ability_entrypoints/pecking_miss
# @dummy
# @environment sgp.ci:ability_entrypoints/pecking_miss
#
# A Pigeon activation that acquires no target must fail without consuming cooldown or telemetry state.

tag @s add sgp.pigeon
gamemode survival @s
scoreboard players set @s sgp.cooldown_ability 0
scoreboard players set @s sgp.duration_ability 77

execute at @s run function sgp.kits:abilities/route_ability

assert not entity @s[tag=sgp.is_pecking]
assert not entity @s[tag=sgp.stats_pecking_active]
assert score @s sgp.duration_ability matches 0
assert score @s sgp.cooldown_ability matches 0

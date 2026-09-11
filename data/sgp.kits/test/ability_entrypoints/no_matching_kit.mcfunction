#> sgp.kits:ability_entrypoints/no_matching_kit
# @dummy
# @environment sgp.ci:ability_entrypoints/no_matching_kit
#
# The public router has no fallback ability: an untagged player must remain untouched.

scoreboard players set @s sgp.cooldown_ability 123
scoreboard players set @s sgp.duration_ability 456
execute at @s run function sgp.kits:abilities/route_ability
assert score @s sgp.cooldown_ability matches 123
assert score @s sgp.duration_ability matches 456
assert not entity @s[tag=sgp.assassin]
assert not entity @s[tag=sgp.is_pecking]
assert not entity @s[tag=sgp.stats_tank_boost_active]
assert not entity @e[tag=sgp.giant_sweep,distance=..5,type=item_display]
assert not entity @e[tag=sgp.ray,distance=..5,type=item_display]
assert not entity @e[tag=sgp.smoke_grenade,distance=..5,type=snowball]

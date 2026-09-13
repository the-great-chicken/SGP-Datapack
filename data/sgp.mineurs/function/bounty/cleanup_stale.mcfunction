#> sgp.mineurs:bounty/cleanup_stale
#
# Remove wanted state retained across logout once its bounty run is no longer current.

execute unless entity @s[tag=sgp.wanted] run return 0
execute if score #bounty_active sgp.dummy matches 1 if score @s sgp.bounty_gen = #generation sgp.bounty_gen run return 0

effect clear @s minecraft:glowing
scoreboard players reset @s sgp.bounty_gen
tag @s remove sgp.wanted

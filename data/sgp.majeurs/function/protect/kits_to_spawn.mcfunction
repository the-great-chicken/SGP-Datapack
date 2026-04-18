#> sgp.majeurs:protect/kits_to_spawn
#
# Executed when a player tries to choose their spawn while Protect is active

glow add @a[team=sgp.rouge] @a[team=sgp.rouge] RED
glow add @a[team=sgp.bleue] @a[team=sgp.bleue] BLUE
glow add @a[tag=sgp.in_game] @a[tag=sgp.roi_rouge] DARK_RED
glow add @a[tag=sgp.in_game] @a[tag=sgp.roi_bleu] DARK_BLUE
tp @s[team=sgp.bleue] @e[type=marker,tag=sgp.marker,name="protect_spawn_bleus",limit=1]
tp @s[team=sgp.rouge] @e[type=marker,tag=sgp.marker,name="protect_spawn_rouges",limit=1]
#> sgp.majeurs:protect/kits_to_spawn
#
# Executed when a player tries to choose their spawn while Protect is active

scoreboard players set @s sgp.kits_vers_spawn 0
function sgp.kits:misc/sort_salle
targetglow @a[team=sgp.rouge] @a[team=sgp.rouge] RED
targetglow @a[team=sgp.bleue] @a[team=sgp.bleue] BLUE
targetglow @a[tag=sgp.in_game] @a[tag=sgp.roi_rouge] DARK_RED
targetglow @a[tag=sgp.in_game] @a[tag=sgp.roi_bleu] DARK_BLUE
tp @s[team=sgp.bleue] @e[type=marker,tag=sgp.marker,name="protect_spawn_bleus",limit=1]
tp @s[team=sgp.rouge] @e[type=marker,tag=sgp.marker,name="protect_spawn_rouges",limit=1]
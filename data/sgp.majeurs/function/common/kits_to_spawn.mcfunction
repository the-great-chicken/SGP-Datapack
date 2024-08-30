#> sgp.majeurs:common/kits_to_spawn
# 
# When a player wants to go from the kits' room to the spawns',
# and a major event needs to change this behavior

# Protéger le Roi
execute if predicate sgp.majeurs:protect/ongoing run tp @s[team=sgp.bleue] @e[type=marker,tag=sgp.marker,name="protect_spawn_bleus",limit=1]
execute if predicate sgp.majeurs:protect/ongoing run tp @s[team=sgp.rouge] @e[type=marker,tag=sgp.marker,name="protect_spawn_rouges",limit=1]
execute if predicate sgp.majeurs:protect/ongoing run scoreboard players set @s sgp.kits_vers_spawn 0
execute if predicate sgp.majeurs:protect/ongoing run function sgp.kits:misc/sort_salle
execute if predicate sgp.majeurs:protect/ongoing run targetglow @a[team=sgp.rouge] @a[gamemode=survival,team=sgp.rouge] RED
execute if predicate sgp.majeurs:protect/ongoing run targetglow @a[team=sgp.bleue] @a[gamemode=survival,team=sgp.bleue] BLUE
execute if predicate sgp.majeurs:protect/ongoing run targetglow @a[tag=sgp.in_game] @a[tag=sgp.roi_rouge] DARK_RED
execute if predicate sgp.majeurs:protect/ongoing run targetglow @a[tag=sgp.in_game] @a[tag=sgp.roi_bleu] DARK_BLUE

# Invasion
execute if predicate sgp.majeurs:invasion/ongoing run tp @s @e[type=marker,tag=sgp.marker,name="Attaquant_Invasion",limit=1,sort=random]
execute if predicate sgp.majeurs:invasion/ongoing run scoreboard players set @s sgp.kits_vers_spawn 0
execute if predicate sgp.majeurs:invasion/ongoing run function sgp.kits:misc/sort_salle
execute if predicate sgp.majeurs:invasion/ongoing run targetglow @a[team=sgp.Attaquant] @a[gamemode=survival,team=sgp.Attaquant] RED
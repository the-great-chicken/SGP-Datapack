#> sgp.majeurs:common/kits_to_spawn
# 
# When a player wants to go from the kits' room to the spawns',
# and a major event needs to change this behavior

# Protéger le Roi
execute if entity @a[predicate=sgp.majeurs:protect/ongoing] run function sgp.majeurs:protect/kits_to_spawn

# Invasion
execute if entity @a[predicate=sgp.majeurs:invasion/ongoing] run tp @s @e[type=marker,tag=sgp.marker,name="Attaquant_Invasion",limit=1,sort=random]
execute if entity @a[predicate=sgp.majeurs:invasion/ongoing] run scoreboard players set @s sgp.kits_vers_spawn 0
execute if entity @a[predicate=sgp.majeurs:invasion/ongoing] run function sgp.kits:misc/sort_salle
execute if entity @a[predicate=sgp.majeurs:invasion/ongoing] run glow add @a[team=sgp.Attaquant] @a[gamemode=survival,team=sgp.Attaquant] red
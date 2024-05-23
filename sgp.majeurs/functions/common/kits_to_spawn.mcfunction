# Protéger le Roi
execute if predicate sgp.majeurs:protect/ongoing run tp @s[team=bleue] 2523.5 231 2160 90 0
execute if predicate sgp.majeurs:protect/ongoing run tp @s[team=rouge] 2429.5 229 2172.0 270 0
execute if predicate sgp.majeurs:protect/ongoing run scoreboard players set @s kits_vers_spawn 0
execute if predicate sgp.majeurs:protect/ongoing run execute as @s run function sgp.kits:misc/sort_salle
execute if predicate sgp.majeurs:protect/ongoing run targetglow @a[team=rouge] @a[gamemode=survival,team=rouge] RED
execute if predicate sgp.majeurs:protect/ongoing run targetglow @a[team=bleue] @a[gamemode=survival,team=bleue] BLUE
execute if predicate sgp.majeurs:protect/ongoing run targetglow @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] @a[tag=roi_rouge] DARK_RED
execute if predicate sgp.majeurs:protect/ongoing run targetglow @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] @a[tag=roi_bleu] DARK_BLUE

# Invasion
execute if predicate sgp.majeurs:invasion/ongoing run tp @s @e[type=marker,name="Attaquant_Invasion",limit=1,sort=random]
execute if predicate sgp.majeurs:invasion/ongoing run scoreboard players set @s kits_vers_spawn 0
execute if predicate sgp.majeurs:invasion/ongoing run function sgp.kits:misc/sort_salle
execute if predicate sgp.majeurs:invasion/ongoing run targetglow @a[team=Attaquant] @a[gamemode=survival,team=Attaquant] RED
# Protéger le Roi
execute if predicate majeurs:protect_ongoing run tp @s[team=bleue] 2523.5 231 2160 90 0
execute if predicate majeurs:protect_ongoing run tp @s[team=rouge] 2429.5 229 2172.0 270 0
execute if predicate majeurs:protect_ongoing run scoreboard players set @s kits_vers_spawn 0
execute if predicate majeurs:protect_ongoing run execute as @s run function kits:sort_salle_kits
execute if predicate majeurs:protect_ongoing run targetglow @a[team=rouge] @a[gamemode=survival,team=rouge] RED
execute if predicate majeurs:protect_ongoing run targetglow @a[team=bleue] @a[gamemode=survival,team=bleue] BLUE
execute if predicate majeurs:protect_ongoing run targetglow @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] @a[tag=roi_rouge] DARK_RED
execute if predicate majeurs:protect_ongoing run targetglow @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] @a[tag=roi_bleu] DARK_BLUE

# Invasion
execute if predicate majeurs:invasion_ongoing run tp @s @e[type=marker,name="Attaquant_Invasion",limit=1,sort=random]
execute if predicate majeurs:invasion_ongoing run scoreboard players set @s kits_vers_spawn 0
execute if predicate majeurs:invasion_ongoing run function kits:sort_salle_kits
execute if predicate majeurs:invasion_ongoing run targetglow @a[team=Attaquant] @a[gamemode=survival,team=Attaquant] RED
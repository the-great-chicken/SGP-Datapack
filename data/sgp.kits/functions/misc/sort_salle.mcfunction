#> sgp.kits:misc/sort_salle
# 
# Executed when a player wants to get out of the kits room

execute as @s run trigger sgp.veut_combattant set 0
execute as @s run trigger sgp.veut_roi set 0
execute as @s run trigger sgp.veut_pigeon set 0
execute as @s run trigger sgp.veut_archer set 0
execute as @s run trigger sgp.veut_tank set 0
execute as @s run trigger sgp.veut_vindicateur set 0
execute as @s run trigger sgp.veut_pyromane set 0
execute as @s run trigger sgp.veut_cancer set 0
execute as @s run trigger sgp.veut_enderman set 0
execute as @s run trigger sgp.veut_alchimiste set 0
execute as @s run trigger sgp.veut_poseidon set 0
execute as @s run trigger sgp.veut_eclaireur set 0
execute as @s run trigger sgp.veut_random set 0

execute if entity @s[scores={sgp.sort_kits=1..}] run trigger sgp.kits_vers_spawn set 0
execute if entity @s[scores={sgp.sort_kits=1..}] run clear @s
execute if entity @s[scores={sgp.sort_kits=1..}] run effect clear @s
execute if entity @s[scores={sgp.sort_kits=1..}] run tp @s @e[type=marker,tag=sgp.marker,name="accueil",limit=1]
execute if entity @s[scores={sgp.sort_kits=1..}] run scoreboard players set @s sgp.sort_kits 0

execute if entity @s[scores={sgp.kits_vers_spawn=1..}] run trigger sgp.sort_kits set 0
execute if entity @s[scores={sgp.kits_vers_spawn=1..}] unless score #confines_secondes sgp.timer > 0 sgp.dummy run function sgp.spawns:enable_triggers
execute if entity @s[scores={sgp.kits_vers_spawn=1..}] unless score #confines_secondes sgp.timer > 0 sgp.dummy run tp @s @e[type=marker,tag=sgp.marker,name="spawns",limit=1]
execute if entity @s[scores={sgp.kits_vers_spawn=1..}] if score #confines_secondes sgp.timer matches 1.. run tp @s @e[type=marker,tag=sgp.marker,name="Confinement",limit=1,sort=random] 
execute if entity @s[scores={sgp.kits_vers_spawn=1..}] run scoreboard players set @s sgp.kits_vers_spawn 0
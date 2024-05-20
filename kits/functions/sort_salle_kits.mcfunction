execute as @s run trigger veut_combattant set 0
execute as @s run trigger veut_roi set 0
execute as @s run trigger veut_pigeon set 0
execute as @s run trigger veut_archer set 0
execute as @s run trigger veut_tank set 0
execute as @s run trigger veut_vindicateur set 0
execute as @s run trigger veut_pyromane set 0
execute as @s run trigger veut_cancer set 0
execute as @s run trigger veut_enderman set 0
execute as @s run trigger veut_alchimiste set 0
execute as @s run trigger veut_poseidon set 0
execute as @s run trigger veut_eclaireur set 0
execute as @s run trigger veut_random set 0

execute if entity @s[scores={sort_kits=1..}] run trigger kits_vers_spawn set 0
execute if entity @s[scores={sort_kits=1..}] run clear @s
execute if entity @s[scores={sort_kits=1..}] run effect clear @s
execute if entity @s[scores={sort_kits=1..}] run tp @s 2422 251.5 2136 0 0
execute if entity @s[scores={sort_kits=1..}] run scoreboard players set @s sort_kits 0

execute if entity @s[scores={kits_vers_spawn=1..}] run trigger sort_kits set 0
execute if entity @s[scores={kits_vers_spawn=1..}] unless score #confines_secondes timer > 0 dummy run function spawns:enable_triggers
execute if entity @s[scores={kits_vers_spawn=1..}] unless score #confines_secondes timer > 0 dummy run tp @s 2423 251.5 2154 0 0
execute if entity @s[scores={kits_vers_spawn=1..}] if score #confines_secondes timer > 0 dummy run tp @s @e[type=marker,name="Confinement",limit=1,sort=random] 
execute if entity @s[scores={kits_vers_spawn=1..}] run scoreboard players set @s kits_vers_spawn 0
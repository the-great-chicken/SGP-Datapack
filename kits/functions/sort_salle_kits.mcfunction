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
execute if entity @s[scores={sort_kits=1..}] run scoreboard players set @s sort_kits 0
setblock 2413 245 2136 redstone_block
execute if entity @s[scores={kits_vers_spawn=1..}] run trigger sort_kits set 0
execute if entity @s[scores={kits_vers_spawn=1..}] run scoreboard players set @s kits_vers_spawn 0
setblock 2414 245 2136 redstone_block
scoreboard players enable @s veut_combattant
scoreboard players enable @s veut_roi
scoreboard players enable @s veut_pigeon
scoreboard players enable @s veut_archer
scoreboard players enable @s veut_tank
scoreboard players enable @s veut_vindicateur
scoreboard players enable @s veut_pyromane
scoreboard players enable @s veut_cancer
scoreboard players enable @s veut_enderman
scoreboard players enable @s veut_alchimiste
scoreboard players enable @s veut_poseidon
scoreboard players enable @s veut_eclaireur
scoreboard players enable @s veut_random
scoreboard players enable @s sort_kits
scoreboard players enable @s kits_vers_spawn
execute if entity @s[scores={entre_kits=1..}] as @s run trigger entre_cosm set 0
execute if entity @s[scores={entre_kits=1..}] run scoreboard players set @s entre_kits 0
setblock 2413 245 2135 redstone_block
execute if entity @s[scores={spawn_vers_kits=1..}] run scoreboard players set @s spawn_vers_kits 0
setblock 2415 245 2136 redstone_block
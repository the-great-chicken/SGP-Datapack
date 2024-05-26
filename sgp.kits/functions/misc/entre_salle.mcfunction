clear @s
effect clear @s
tp @s @e[tag=sgp.marker,name="kits",limit=1]
scoreboard players enable @s sgp.veut_combattant
scoreboard players enable @s sgp.veut_roi
scoreboard players enable @s sgp.veut_pigeon
scoreboard players enable @s sgp.veut_archer
scoreboard players enable @s sgp.veut_tank
scoreboard players enable @s sgp.veut_vindicateur
scoreboard players enable @s sgp.veut_pyromane
scoreboard players enable @s sgp.veut_cancer
scoreboard players enable @s sgp.veut_enderman
scoreboard players enable @s sgp.veut_alchimiste
scoreboard players enable @s sgp.veut_poseidon
scoreboard players enable @s sgp.veut_eclaireur
scoreboard players enable @s sgp.veut_random
scoreboard players enable @s sgp.sort_kits
scoreboard players enable @s sgp.kits_vers_spawn
execute if entity @s[scores={sgp.entre_kits=1..}] as @s run trigger sgp.entre_cosm set 0
execute if entity @s[scores={sgp.entre_kits=1..}] as @s run function sgp.misc:scoreboards/player_initialization
execute if entity @s[scores={sgp.entre_kits=1..}] run scoreboard players set @s sgp.entre_kits 0
execute if entity @s[scores={sgp.spawn_vers_kits=1..}] as @s run function sgp.spawns:disable_triggers
execute if entity @s[scores={sgp.spawn_vers_kits=1..}] run scoreboard players set @s sgp.spawn_vers_kits 0
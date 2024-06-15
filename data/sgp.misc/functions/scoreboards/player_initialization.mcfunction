#> sgp.misc:scoreboards/player_initialization
# 
# Set at 0 the player's scoreboard values, as they cannot
# be compared when they are not set to a value

scoreboard players add @s sgp.plus_grande_streak 0

scoreboard players add @s sgp.pyromane_found 0
scoreboard players add @s sgp.cancer_found 0
scoreboard players add @s sgp.roi_found 0
scoreboard players add @s sgp.pigeon_found 0
scoreboard players add @s sgp.tank_found 0
scoreboard players add @s sgp.enderman_found 0
scoreboard players add @s sgp.alchimiste_found 0
scoreboard players add @s sgp.poseidon_found 0
scoreboard players add @s sgp.eclaireur_found 0

execute unless score @s sgp.UUID matches 0.. unless score @s sgp.UUID matches ..0 store result score @s sgp.UUID run data get entity @s UUID[1]

tag @s add sgp.initialize_lieux
execute as @e[type=marker,tag=sgp.marker,name="lieu"] run function sgp.misc:scoreboards/player_initialization_lieux with entity @s data
tag @s remove sgp.initialize_lieux

scoreboard players add @s sgp.laby_fin 0
scoreboard players add @s sgp.jump_hardest_done 0
scoreboard players add @s sgp.jump_diff_2_done 0

scoreboard players add @s sgp.teleporteur 0

bossbar set sgp:lgp players @a

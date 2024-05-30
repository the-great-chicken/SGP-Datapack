#> sgp.misc:scoreboards/player_initialization
# 
# Set at 0 the player's scoreboard values, as they cannot
# be compared when they are not set to a value

execute unless score @s sgp.plus_grande_streak matches 0.. run scoreboard players set @s sgp.plus_grande_streak 0

execute unless score @s sgp.pyromane_found matches 0.. run scoreboard players set @s sgp.pyromane_found 0
execute unless score @s sgp.cancer_found matches 0.. run scoreboard players set @s sgp.cancer_found 0
execute unless score @s sgp.roi_found matches 0.. run scoreboard players set @s sgp.roi_found 0
execute unless score @s sgp.pigeon_found matches 0.. run scoreboard players set @s sgp.pigeon_found 0
execute unless score @s sgp.tank_found matches 0.. run scoreboard players set @s sgp.tank_found 0
execute unless score @s sgp.enderman_found matches 0.. run scoreboard players set @s sgp.enderman_found 0
execute unless score @s sgp.alchimiste_found matches 0.. run scoreboard players set @s sgp.alchimiste_found 0
execute unless score @s sgp.poseidon_found matches 0.. run scoreboard players set @s sgp.poseidon_found 0
execute unless score @s sgp.eclaireur_found matches 0.. run scoreboard players set @s sgp.eclaireur_found 0

execute unless score @s sgp.UUID matches 0.. unless score @s sgp.UUID matches ..0 store result score @s sgp.UUID run data get entity @s UUID[1]

tag @s add sgp.initialize_lieux
execute as @e[type=marker,tag=sgp.marker,name="lieu"] run function sgp.misc:scoreboards/player_initialization_lieux with entity @s data
tag @s remove sgp.initialize_lieux

execute unless score @s sgp.laby_fin matches 0.. run scoreboard players set @s sgp.laby_fin 0
execute unless score @s sgp.jump_hardest_done matches 0.. run scoreboard players set @s sgp.jump_hardest_done 0
execute unless score @s sgp.jump_diff_2_done matches 0.. run scoreboard players set @s sgp.jump_diff_2_done 0

execute unless score @s sgp.teleporteur matches 0.. run scoreboard players set @s sgp.teleporteur 0

bossbar set sgp:lgp players @a

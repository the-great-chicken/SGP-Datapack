#> sgp.cosmetics:kill_effects/update_death_reaper_coords
# 
# Teleports the Death Reaper to the position where the player died

execute store result entity @s Pos[0] double 0.01 run scoreboard players get @p[scores={sgp.death_effect=1..}] sgp.posx1
execute store result entity @s Pos[1] double 0.01 run scoreboard players get @p[scores={sgp.death_effect=1..}] sgp.posy1
execute store result entity @s Pos[2] double 0.01 run scoreboard players get @p[scores={sgp.death_effect=1..}] sgp.posz1
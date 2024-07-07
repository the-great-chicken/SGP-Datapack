#> sgp.cosmetics:
# 
# Executed when a player wants to leave the cosmetics room

tp @s @n[type=marker,tag=sgp.marker,name="accueil"]
execute as @s run function sgp.cosmetics:common/disable_triggers
scoreboard players set @s sgp.sort_cosm 0
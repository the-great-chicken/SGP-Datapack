#> sgp.cosmetics:
# 
# Executed when a player wants to leave the cosmetics room

tp @s @e[tag=sgp.marker,name="accueil",limit=1]
execute as @s run function sgp.cosmetics:common/disable_triggers
scoreboard players set @s sgp.sort_cosm 0
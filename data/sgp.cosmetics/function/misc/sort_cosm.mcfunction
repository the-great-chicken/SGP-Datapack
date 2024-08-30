#> sgp.cosmetics:
# 
# Executed when a player wants to leave the cosmetics room

tp @s @e[type=marker,tag=sgp.marker,name="accueil",limit=1]
function sgp.cosmetics:common/disable_triggers
scoreboard players set @s sgp.sort_cosm 0
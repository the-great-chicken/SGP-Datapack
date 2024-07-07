#> sgp.cosmetics:misc/entre_cosm
# 
# Executed when a player wants to enter the cosmetics room

execute as @s run function sgp.cosmetics:common/enable_triggers
clear @s
scoreboard players enable @s sgp.sort_cosm
tp @s @n[type=marker,tag=sgp.marker,name="salle_cosm"]
scoreboard players set @s sgp.entre_cosm 0

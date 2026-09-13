#> sgp.world:teleporter/out_of_range
# 
# Executed when the player is not on the teleporter anymore (got teleported or cancelled)

stopsound @s ambient block.portal.trigger
scoreboard players set @s sgp.teleporteur 0
scoreboard players reset @s sgp.teleport_source
tag @s remove sgp.to_teleport

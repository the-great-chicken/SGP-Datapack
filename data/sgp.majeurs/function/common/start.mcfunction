#> sgp.majeurs:common/start
#
# Start the game.

execute as @a[tag=sgp.in_game] run function sgp.misc:on_death
function sgp.mineurs:_stop
statuswarp pvp disabled
useglow toggle
function sgp.lore:npcs/disable
#> sgp.majeurs:common/start
#
# Start the game.

team leave @a[tag=sgp.in_game]
execute as @a[tag=sgp.in_game] run function sgp.misc:on_death
function sgp.mineurs:_stop
statuswarp pvp disabled
useglow toggle
team leave @a
function sgp.lore:npcs/disable
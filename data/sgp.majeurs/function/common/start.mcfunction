#> sgp.majeurs:common/start
#
# Start the game.

# Pause statistics before teams are cleared and synthetic death cleanup runs;
# the entity predicate only becomes true after the event teams are assigned.
function sgp.kits:stats_collector/pause_for_major_event

team leave @a[tag=sgp.in_game]
execute as @a[tag=sgp.in_game] run function sgp.misc:on_death
function sgp.mineurs:_stop
statuswarp pvp disabled
useglow toggle
team leave @a
function sgp.lore:npcs/disable

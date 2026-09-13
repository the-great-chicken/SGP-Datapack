#> sgp.majeurs:common/start
#
# Start the game.

# A manually-started round must not inherit reconnect state before the regular
# tick repair has had a chance to run.
function sgp.majeurs:repair_reconnected_players

gamemode survival @a[tag=sgp.major_spectator]
tag @a remove sgp.major_participant
tag @a remove sgp.major_spectator
tag @a[tag=sgp.in_game] add sgp.major_participant
gamemode survival @a[tag=sgp.major_participant]

# Pause statistics before teams are cleared and synthetic death cleanup runs;
# the entity predicate only becomes true after the event teams are assigned.
function sgp.kits:stats_collector/pause_for_major_event

team leave @a[tag=sgp.major_participant]
execute as @a[tag=sgp.major_participant] run function sgp.misc:on_death
function sgp.mineurs:_stop
function #sgp.hooks:tgc/majeurs/common/start_1

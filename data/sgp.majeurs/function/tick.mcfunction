#> sgp.majeurs:tick
#
# Shared lobby boundary and retained-event tick entry point.

# Recover stale round state when no event is active.
execute unless entity @a[predicate=sgp.majeurs:event_in_progress] unless entity @a[tag=sgp.major_participant] run return 0
execute unless entity @a[predicate=sgp.majeurs:event_in_progress] run gamemode survival @a[tag=sgp.major_participant]
execute unless entity @a[predicate=sgp.majeurs:event_in_progress] run gamemode survival @a[tag=sgp.major_spectator]
execute unless entity @a[predicate=sgp.majeurs:event_in_progress] run tag @a[tag=sgp.major_spectator] remove sgp.major_participant
execute unless entity @a[predicate=sgp.majeurs:event_in_progress] run tag @a[tag=sgp.major_spectator] remove sgp.major_spectator
execute unless entity @a[predicate=sgp.majeurs:event_in_progress] run return 0

# Eliminate participants who leave, then admit new arrivals as spectators.
execute as @a[tag=sgp.major_participant,tag=!sgp.in_game] run function sgp.majeurs:common/participant_exit
execute if entity @a[predicate=sgp.majeurs:event_in_progress] as @a[tag=sgp.in_game,tag=!sgp.major_participant,tag=!sgp.major_spectator] run function sgp.majeurs:common/spectator_join

# Registered event ticks
function #sgp.majeurs:events/tick

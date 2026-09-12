#> sgp.majeurs:repair_reconnected_players
#
# Repair player-local major-event state that could not be cleared while the
# player was offline. Active participants always belong to one of the major
# event teams; a retained participant tag without such a team is stale.

execute as @a[tag=sgp.major_participant,predicate=!sgp.majeurs:event_in_progress] \
    run function sgp.majeurs:common/cleanup_stale_participant

# Mid-round spectators do not belong to an event team, so only release them
# once no major event is active at all.
execute unless entity @a[predicate=sgp.majeurs:event_in_progress] \
    as @a[tag=sgp.major_spectator] \
        run function sgp.majeurs:common/cleanup_stale_spectator

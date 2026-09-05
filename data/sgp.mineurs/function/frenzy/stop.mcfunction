#> sgp.mineurs:frenzy/stop

# Restore only a live event. A stale backup must never overwrite newer settings.
execute if data storage sgp:data mineurs.haste.active \
    if data storage sgp:data mineurs.haste.cd_backup \
        run data modify storage sgp:data kits.ability_cooldowns set from storage sgp:data mineurs.haste.cd_backup

# Make stop idempotent and prevent a later _stop from replaying an old backup.
data remove storage sgp:data mineurs.haste.cd_backup
data remove storage sgp:data mineurs.haste.active
data remove storage sgp:data mineurs.haste.walker

schedule clear sgp.mineurs:frenzy/end
function sgp.mineurs:common/timed_event/stop {event:"frenzy"}

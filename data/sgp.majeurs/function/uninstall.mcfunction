#> sgp.majeurs:uninstall

# Stop the scheduler, pending rounds, and any active event before removing state.
function sgp.majeurs:scheduler/abort
function sgp.majeurs:repair_reconnected_players
execute as @a[scores={sgp.synthetic_death=1..,sgp.just_died=1..}] run function sgp.misc:on_death
function #sgp.majeurs:events/uninstall

tag @a remove sgp.major.hide_and_seek
tag @a remove sgp.major.protect
tag @a remove sgp.major.pco

# ---------- Remove Storages -----------

data remove storage sgp:data majeurs

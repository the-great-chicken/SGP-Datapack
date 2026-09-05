#> sgp.majeurs:uninstall

# Stop the scheduler, pending rounds, and any active event before removing state.
function sgp.majeurs:scheduler/abort
function #sgp.majeurs:events/uninstall

# ---------- Remove Storages -----------

data remove storage sgp:data majeurs

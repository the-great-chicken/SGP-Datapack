#> sgp.majeurs:uninstall

# Stop the scheduler, pending rounds, and any active event before removing state.
function sgp.majeurs:scheduler/abort
function #sgp.majeurs:events/uninstall

# ---------- Remove Objectives ----------

scoreboard objectives remove sgp.link_teams
scoreboard objectives remove sgp.teammate_deaths



# ---------- Remove Storages -----------

data remove storage sgp:data majeurs

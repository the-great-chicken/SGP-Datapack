#> sgp.ci:pyromane_fire/cleanup
# Remove lingering-fire fixtures, source TNT, linked interactions, and test players.

kill @e[tag=sgp.ci.fire,type=marker]
kill @e[tag=sgp.ci.fire,type=tnt]
kill @e[tag=sgp.ci.fire,type=interaction]
function sgp.ci:players/cleanup

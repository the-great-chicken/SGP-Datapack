#> sgp.ci:smoke_grenade/cleanup
# Remove smoke-grenade displays/projectiles and disconnect fixture players.

kill @e[tag=sgp.ci.smoke,type=item_display]
kill @e[tag=sgp.ci.smoke,type=snowball]
function sgp.ci:players/cleanup

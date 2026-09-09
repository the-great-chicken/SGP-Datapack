#> sgp.ci:smoke_grenade/scenarios/stale_flight_state

function sgp.ci:smoke_grenade/flight
function sgp.kits:abilities/smoke_grenade/tick
execute as @e[tag=sgp.ci.smoke_airborne,type=item_display] run ride @s dismount
function sgp.kits:abilities/smoke_grenade/tick
assert not entity @e[tag=sgp.ci.smoke_airborne,type=item_display]
assert entity @e[tag=sgp.ci.smoke,type=snowball]

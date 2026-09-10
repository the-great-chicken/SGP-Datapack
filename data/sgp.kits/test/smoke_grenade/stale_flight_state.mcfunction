#> sgp.kits:smoke_grenade/stale_flight_state
# @environment sgp.ci:smoke_grenade/stale_flight_state
#
# A previously airborne display still detonates after losing its vehicle.

function sgp.ci:smoke_grenade/flight
function sgp.kits:abilities/smoke_grenade/tick
execute as @e[tag=sgp.ci.smoke_airborne,type=item_display] run ride @s dismount
function sgp.kits:abilities/smoke_grenade/tick
assert not entity @e[tag=sgp.ci.smoke_airborne,type=item_display]
assert entity @e[tag=sgp.ci.smoke,type=snowball]

#> sgp.ci:smoke_grenade/scenarios/flight

function sgp.ci:smoke_grenade/flight
function sgp.kits:abilities/smoke_grenade/tick
function sgp.kits:abilities/smoke_grenade/tick
assert entity @e[tag=sgp.ci.smoke_airborne,type=item_display]
execute as @e[tag=sgp.ci.smoke_airborne,type=item_display] on vehicle run tag @s add sgp.ci.smoke_vehicle
assert entity @e[tag=sgp.ci.smoke_vehicle,type=snowball]

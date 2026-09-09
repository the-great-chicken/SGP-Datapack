#> sgp.ci:smoke_grenade/scenarios/overlapping_landing

function sgp.ci:smoke_grenade/landed
function sgp.ci:smoke_grenade/flight
function sgp.kits:abilities/smoke_grenade/tick
assert not entity @e[tag=sgp.ci.smoke_landed,type=item_display]
assert entity @e[tag=sgp.ci.smoke_airborne,type=item_display]

#> sgp.kits:smoke_grenade/overlapping_landing
# @environment sgp.ci:smoke_grenade/overlapping_landing
#
# A landed grenade detonates even when another grenade is flying at the same position.

function sgp.ci:smoke_grenade/landed
function sgp.ci:smoke_grenade/flight
function sgp.kits:abilities/smoke_grenade/tick
assert not entity @e[tag=sgp.ci.smoke_landed,type=item_display]
assert entity @e[tag=sgp.ci.smoke_airborne,type=item_display]

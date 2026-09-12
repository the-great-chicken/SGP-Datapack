#> sgp.kits:smoke_grenade/landing
# @environment sgp.ci:smoke_grenade/landing
#
# A detached display is consumed on landing and remains absent on subsequent updates.

function sgp.ci:smoke_grenade/flight
execute as @e[tag=sgp.ci.smoke_airborne,type=item_display] run ride @s dismount
kill @e[tag=sgp.ci.smoke,type=snowball]
function sgp.kits:abilities/smoke_grenade/tick
assert not entity @e[tag=sgp.ci.smoke_airborne,type=item_display]
function sgp.kits:abilities/smoke_grenade/tick
assert not entity @e[tag=sgp.ci.smoke,type=item_display]

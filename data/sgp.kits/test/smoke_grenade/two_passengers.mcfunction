#> sgp.kits:smoke_grenade/two_passengers
# @environment sgp.ci:smoke_grenade/two_passengers
#
# Two overlapping airborne grenades retain both displays.

function sgp.ci:smoke_grenade/flight
function sgp.ci:smoke_grenade/flight
function sgp.kits:abilities/smoke_grenade/tick
scoreboard players set #smoke_count sgp.dummy 0
execute as @e[tag=sgp.ci.smoke_airborne,type=item_display] run scoreboard players add #smoke_count sgp.dummy 1
assert score #smoke_count sgp.dummy matches 2

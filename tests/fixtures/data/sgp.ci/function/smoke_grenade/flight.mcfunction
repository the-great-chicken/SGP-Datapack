#> sgp.ci:smoke_grenade/flight
# Create the canonical in-flight smoke grenade as a snowball with its visual passenger.

summon snowball ~2.5 ~2 ~2.5 {Tags:["sgp.ci.smoke","sgp.smoke_grenade"],NoGravity:1b,Passengers:[{id:"minecraft:item_display",Tags:["sgp.ci.smoke","sgp.smoke_visual","sgp.ci.smoke_airborne"]}]}
scoreboard players set @e[tag=sgp.ci.smoke_airborne,type=item_display] sgp.id 97001
assert entity @e[tag=sgp.ci.smoke_airborne,type=item_display]

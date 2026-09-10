#> sgp.ci:smoke_grenade/landed
# Create a pre-existing landed grenade at the flight position for overlap/isolation checks.

summon item_display ~2.5 ~2 ~2.5 {Tags:["sgp.ci.smoke","sgp.smoke_visual","sgp.ci.smoke_landed"]}
scoreboard players set @e[tag=sgp.ci.smoke_landed,type=item_display] sgp.id 97002

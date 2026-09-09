#> sgp.ci:repulsion/scenarios/rearm/2

function sgp.ci:repulsion/expect_impulse {axis:2,range:"..-1"}
execute as @e[tag=sgp.ci.repulsion,type=husk] at @s run tp @s ~ ~ ~ 180 0
data merge entity @e[tag=sgp.ci.repulsion,limit=1,type=husk] {Motion:[0.0d,0.0d,0.0d]}
scoreboard players set @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,type=husk] sgp.trigger_repulsion 1

#> sgp.ci:repulsion/phases/rearm/assert_first_and_rearm
# Verify the first impulse, reverse and stop the wearer, then arm the second trigger.

function sgp.ci:repulsion/expect_impulse {axis:2,range:"..-1"}
execute as @e[tag=sgp.ci.repulsion,type=husk] at @s run tp @s ~ ~ ~ 180 0
data merge entity @e[tag=sgp.ci.repulsion,limit=1,type=husk] {Motion:[0.0d,0.0d,0.0d]}
function sgp.ci:repulsion/arm

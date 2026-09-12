#> sgp.ci:repulsion/phases/facing/arm_west
# Rotate the wearer west and arm Repulsion while preserving the fixed arena execution context.

execute as @e[tag=sgp.ci.repulsion,type=husk] at @s run tp @s ~ ~ ~ 90 0
function sgp.ci:repulsion/arm

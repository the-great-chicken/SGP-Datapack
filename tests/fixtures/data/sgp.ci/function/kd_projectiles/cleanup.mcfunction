#> sgp.ci:kd_projectiles/cleanup

kill @e[tag=sgp.ci.kd_arrow,type=arrow]
# Move dying mobs away from the target area before the next test.
execute as @e[tag=sgp.ci.kd_target,type=husk] at @s run tp @s ~ -1000 ~
kill @e[tag=sgp.ci.kd_target,type=husk]
function sgp.ci:players/cleanup

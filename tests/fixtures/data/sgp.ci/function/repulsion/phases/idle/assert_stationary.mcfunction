#> sgp.ci:repulsion/phases/idle/assert_stationary
# Verify an unarmed wearer remains stationary and its trigger stays clear in the fixed arena.

assert entity @e[tag=sgp.ci.repulsion,scores={sgp.trigger_repulsion=0},type=husk]
execute as @e[tag=sgp.ci.repulsion,scores={sgp.trigger_repulsion=0},type=husk] run function sgp.ci:repulsion/expect_stationary

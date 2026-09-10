#> sgp.ci:repulsion/phases/unequipped/assert_ignored
# Verify an unequipped wearer stays stationary and its trigger is not consumed.

assert entity @e[tag=sgp.ci.repulsion,scores={sgp.trigger_repulsion=1},type=husk]
execute as @e[tag=sgp.ci.repulsion,scores={sgp.trigger_repulsion=1},type=husk] run function sgp.ci:repulsion/expect_stationary

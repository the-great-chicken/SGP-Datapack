#> sgp.ci:repulsion/phases/wearer_isolation/assert_isolated
# Verify only the armed wearer moves while the peer remains untriggered and stationary.

function sgp.ci:repulsion/expect_impulse {axis:2,range:"..-1"}
assert entity @e[tag=sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
execute as @e[tag=sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk] run function sgp.ci:repulsion/expect_stationary

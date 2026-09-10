#> sgp.ci:repulsion/scenarios/wearer_isolation/2
# Verify only the armed wearer moves and the peer remains untriggered and stationary.

function sgp.ci:repulsion/expect_impulse {axis:2,range:"..-1"}
assert entity @e[tag=sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
execute as @e[tag=sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk] run function sgp.ci:repulsion/expect_stationary

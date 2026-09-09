#> sgp.ci:repulsion/scenarios/unequipped/2

assert entity @e[tag=sgp.ci.repulsion,scores={sgp.trigger_repulsion=1},type=husk]
execute as @e[tag=sgp.ci.repulsion,scores={sgp.trigger_repulsion=1},type=husk] run function sgp.ci:repulsion/expect_stationary

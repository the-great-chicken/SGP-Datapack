#> sgp.ci:repulsion/scenarios/idle/2

assert entity @e[tag=sgp.ci.repulsion,scores={sgp.trigger_repulsion=0},type=husk]
execute as @e[tag=sgp.ci.repulsion,scores={sgp.trigger_repulsion=0},type=husk] run function sgp.ci:repulsion/expect_stationary

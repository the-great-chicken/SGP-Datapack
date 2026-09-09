#> sgp.ci:repulsion/expect_impulse

# {axis, range}: motion component multiplied by 10000.
assert entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
$execute store result score #ci.repulsion.motion sgp.dummy run data get entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,limit=1,type=husk] Motion[$(axis)] 10000
$assert score #ci.repulsion.motion sgp.dummy matches $(range)

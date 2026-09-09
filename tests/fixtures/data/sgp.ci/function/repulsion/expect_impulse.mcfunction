#> sgp.ci:repulsion/expect_impulse

# {axis, range}: motion component multiplied by 10000.
assert entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,type=husk]
scoreboard players operation #ci.repulsion.trigger sgp.dummy = @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,limit=1,type=husk] sgp.trigger_repulsion
assert score #ci.repulsion.trigger sgp.dummy matches 0
$execute store result score #ci.repulsion.motion sgp.dummy run data get entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,limit=1,type=husk] Motion[$(axis)] 10000
$assert score #ci.repulsion.motion sgp.dummy matches $(range)

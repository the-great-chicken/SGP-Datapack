#> sgp.ci:repulsion/expect_stationary
# Check each component; NBT list predicates do not compare positions within a list.

execute store result score #ci.repulsion.x sgp.dummy run data get entity @s Motion[0] 10000
execute store result score #ci.repulsion.y sgp.dummy run data get entity @s Motion[1] 10000
execute store result score #ci.repulsion.z sgp.dummy run data get entity @s Motion[2] 10000
assert score #ci.repulsion.x sgp.dummy matches 0
assert score #ci.repulsion.y sgp.dummy matches 0
assert score #ci.repulsion.z sgp.dummy matches 0

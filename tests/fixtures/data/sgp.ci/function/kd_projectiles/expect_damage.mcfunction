#> sgp.ci:kd_projectiles/expect_damage
# `{health: score range (Health * 1000)}`
#
# Check the target's post-hit health and that vanilla damage attribution points back to the shooter.

execute store result score #ci.kd.health sgp.dummy run data get entity @n[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,type=husk] Health 1000
$assert score #ci.kd.health sgp.dummy matches $(health)
execute as @n[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,type=husk] on attacker run tag @s add sgp.ci.kd_attacker
assert entity @s[tag=sgp.ci.kd_attacker]

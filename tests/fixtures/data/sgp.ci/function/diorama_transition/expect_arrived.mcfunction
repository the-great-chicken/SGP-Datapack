#> sgp.ci:diorama_transition/expect_arrived
# {id, x, z, yaw, pitch}
assert entity @s[gamemode=survival]
assert score @s sgp.anim_timer matches 0
$execute positioned $(x) ~1 $(z) run assert entity @s[distance=..0.01]
execute store result score #ci.transition.yaw sgp.dummy run data get entity @s Rotation[0] 1000
execute store result score #ci.transition.pitch sgp.dummy run data get entity @s Rotation[1] 1000
$assert score #ci.transition.yaw sgp.dummy matches $(yaw)
$assert score #ci.transition.pitch sgp.dummy matches $(pitch)
$assert not entity @e[tag=sgp.anim_target,scores={sgp.id=$(id)},type=marker]
$assert not entity @e[tag=sgp.cam,scores={sgp.id=$(id)},type=block_display]

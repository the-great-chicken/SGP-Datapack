#> sgp.ci:diorama_transition/expect_active
# `{id: player id}`
#
# Assert the owner is mid-transition in spectator mode with exactly one camera and target.

assert entity @s[gamemode=spectator]
$execute store result score #ci.transition.cameras sgp.dummy if entity @e[tag=sgp.cam,scores={sgp.id=$(id)},type=block_display]
assert score #ci.transition.cameras sgp.dummy matches 1
$execute store result score #ci.transition.targets sgp.dummy if entity @e[tag=sgp.anim_target,scores={sgp.id=$(id)},type=marker]
assert score #ci.transition.targets sgp.dummy matches 1

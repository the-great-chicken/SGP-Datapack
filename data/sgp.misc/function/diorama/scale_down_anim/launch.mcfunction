#> sgp.misc:diorama/scale_down_anim/launch
# `{id, yaw, pitch: int}`

# warn-off-file target-selector-no-dimension

$rotate @e[tag=sgp.cam,scores={sgp.id=$(id)},limit=1,type=block_display] $(yaw) $(pitch)

$execute positioned as @e[tag=sgp.anim_target,scores={sgp.id=$(id)},limit=1,type=marker] \
    run tp @e[tag=sgp.cam,scores={sgp.id=$(id)},limit=1,type=block_display] ~ ~ ~

$spectate @e[tag=sgp.cam,scores={sgp.id=$(id)},limit=1,type=block_display] @s
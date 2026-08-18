#> sgp.diorama:scale_down_anim/end
# `{[x, y, z, yaw, pitch]: coordinates, id: int}`

$kill @e[tag=sgp.anim_target,scores={sgp.id=$(id)},type=marker]
$kill @e[tag=sgp.cam,scores={sgp.id=$(id)},type=block_display]

$tp @s $(x) $(y) $(z) $(yaw) $(pitch)
gamemode survival @s
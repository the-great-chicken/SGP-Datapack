#> sgp.misc:interactions/tp_to_spawn
# `{[x, y, z, yaw, pitch]: coordinates, article:"à la"|"au"|"aux", title: text component}`

execute if score @s sgp.anim_timer matches 1.. run return fail

$execute unless score #diorama_enabled sgp.dummy matches 1 run return run tp @s $(x) $(y) $(z) $(yaw) $(pitch)

$data modify storage sgp:macro diorama.scale_down_anim.yaw set value $(yaw)
$data modify storage sgp:macro diorama.scale_down_anim.pitch set value $(pitch)
$data modify storage sgp:macro diorama.scale_down_anim.x set value $(x)
$data modify storage sgp:macro diorama.scale_down_anim.y set value $(y)
$data modify storage sgp:macro diorama.scale_down_anim.z set value $(z)

data modify storage sgp:macro diorama.scale_down_anim.init_yaw set from entity @s Rotation[0]
data modify storage sgp:macro diorama.scale_down_anim.init_pitch set from entity @s Rotation[1]

function sgp.diorama:scale_down_anim/init with storage sgp:macro diorama.scale_down_anim

$tellraw @s ["Tu vas spawn $(article)", $(title)]
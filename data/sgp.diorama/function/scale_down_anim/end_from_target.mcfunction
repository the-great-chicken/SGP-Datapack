#> sgp.diorama:scale_down_anim/end_from_target
# `{id: int}`

$data modify storage sgp:macro diorama.scale_down_anim set from entity @e[tag=sgp.anim_target,scores={sgp.id=$(id)},limit=1,type=marker] data
$data modify storage sgp:macro diorama.scale_down_anim.id set value $(id)

function sgp.diorama:scale_down_anim/end with storage sgp:macro diorama.scale_down_anim
#> sgp.ci:diorama_transition/start
# {x, z, yaw, pitch}
# Supply destination coordinates and the initial view exactly as the caller would, without collecting kit stats.
$summon marker $(x) ~1 $(z) {Tags:["sgp.ci.transition_destination"]}
assert entity @e[tag=sgp.ci.transition_destination,distance=..16,type=marker]
$data modify storage sgp:macro diorama.scale_down_anim set value {yaw:$(yaw),pitch:$(pitch)}
data modify storage sgp:macro diorama.scale_down_anim.x set from entity @n[tag=sgp.ci.transition_destination,distance=..16,type=marker] Pos[0]
data modify storage sgp:macro diorama.scale_down_anim.y set from entity @n[tag=sgp.ci.transition_destination,distance=..16,type=marker] Pos[1]
data modify storage sgp:macro diorama.scale_down_anim.z set from entity @n[tag=sgp.ci.transition_destination,distance=..16,type=marker] Pos[2]
data modify storage sgp:macro diorama.scale_down_anim.init_yaw set from entity @s Rotation[0]
data modify storage sgp:macro diorama.scale_down_anim.init_pitch set from entity @s Rotation[1]
kill @e[tag=sgp.ci.transition_destination,distance=..16,type=marker]
execute at @s run function sgp.diorama:scale_down_anim/init with storage sgp:macro diorama.scale_down_anim

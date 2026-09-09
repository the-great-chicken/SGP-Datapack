#> sgp.ci:diorama_hover/update
assert entity @e[tag=sgp.ci.hover,distance=..16,type=marker]
execute as @n[tag=sgp.ci.hover,distance=..16,type=marker] at @s run function sgp.diorama:hover/model {id:93001}
assert not entity @e[tag=sgp.ci.hover,tag=sgp.hover_candidate,distance=..16,type=interaction]
assert entity @e[tag=sgp.ci.hover_unrelated,distance=..16,nbt={transformation:{scale:[1f,1f,1f]}},type=text_display]

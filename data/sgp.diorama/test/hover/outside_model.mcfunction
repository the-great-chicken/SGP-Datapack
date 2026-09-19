#> sgp.diorama:hover/outside_model
# @dummy
# @environment sgp.ci:diorama_hover/outside_model

function sgp.ci:diorama_hover/fixture
# The first button sits exactly on the model's upper face; the second lies outside X.
data modify entity @n[tag=sgp.ci.hover,type=marker] data.mdy set value 0
tp @e[tag=sgp.ci.hover_first,distance=..16,type=interaction] ~3.5 ~2 ~5.5
tp @e[tag=sgp.ci.hover_first,distance=..16,type=text_display] ~3.5 ~2 ~5.5
tp @e[tag=sgp.ci.hover_second,distance=..16,type=interaction] ~12.5 ~1 ~5.5
tp @e[tag=sgp.ci.hover_second,distance=..16,type=text_display] ~12.5 ~1 ~5.5
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:1,scale:0.7}
scoreboard players set @e[tag=sgp.ci.hover_second,distance=..16,type=interaction] sgp.hover_time 2
execute as @e[tag=sgp.ci.hover_second,distance=..16,type=interaction] at @s run function sgp.diorama:hover/grow

# Another model's active button must retain its own timer and hover state.
summon interaction ~9.5 ~1 ~9.5 {Tags:["sgp.ci.hover","sgp.ci.hover_neighbor","sgp.spawn_tper_93002","sgp.spawn_hovered"],width:0.14f,height:0.14f}
scoreboard players set @e[tag=sgp.ci.hover_neighbor,distance=..16,type=interaction] sgp.hover_time 2
tp @s ~3.5 ~1 ~1.5 180 0
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:1,scale:0.7}
function sgp.ci:diorama_hover/expect {target:second,active:1,scale:0.7}
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:0,scale:0.55}
function sgp.ci:diorama_hover/expect {target:second,active:0,scale:0.55}
assert entity @e[tag=sgp.ci.hover_neighbor,tag=sgp.spawn_hovered,distance=..16,scores={sgp.hover_time=2},type=interaction]

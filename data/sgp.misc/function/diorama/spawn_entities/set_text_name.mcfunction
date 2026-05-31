data merge entity @s {Tags:["sgp.spawn_tper_text"],transformation:{scale:[0.55f,0.55f,0.55f]}, billboard:center, shadow:true, see_through:true, background:0, view_range:0.15f}
$data modify entity @s text set value $(title)
$data modify entity @s text.extra set value ["\n$(icon)"]
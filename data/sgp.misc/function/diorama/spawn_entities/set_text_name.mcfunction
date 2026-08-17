#> sgp.misc:diorama/spawn_entities/set_text_name

data merge entity @s {transformation:{scale:[0.55f,0.55f,0.55f]}, billboard:center, shadow:true, see_through:true, background:0, view_range:0.15f}
$data modify entity @s text set value $(title)
$data modify entity @s text.extra set value ["\n$(icon)"]
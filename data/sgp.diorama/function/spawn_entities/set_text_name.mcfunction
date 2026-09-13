#> sgp.diorama:spawn_entities/set_text_name

data merge entity @s {transformation:{scale:[0.55f,0.55f,0.55f]}, interpolation_duration:4, billboard:center, shadow:true, see_through:true, background:0, view_range:0.15f}
# Assemble title and icon before Minecraft normalizes the text component.
$data modify storage sgp:macro diorama.spawn_label set value $(title)
$data modify storage sgp:macro diorama.spawn_label.extra set value ["\n$(icon)"]
data modify entity @s text set from storage sgp:macro diorama.spawn_label

# Link the display as a child so hover transitions can resolve the exact label.
scoreboard players operation @s bs.link.to = $spawn_label_parent bs.in

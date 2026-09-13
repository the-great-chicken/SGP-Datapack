#> sgp.diorama:spawn_entities/remove_button
# Remove this spawn button and its label, including labels on the model boundary.

scoreboard players operation $spawn_label_parent bs.in = @s bs.id
execute as @e[tag=sgp.spawn_tper_text,distance=..0.1,type=text_display] if score @s bs.link.to = $spawn_label_parent bs.in run kill @s
kill @s

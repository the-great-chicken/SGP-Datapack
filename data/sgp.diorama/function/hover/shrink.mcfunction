#> sgp.diorama:hover/shrink
# Executed as and at a spawn interaction.

tag @s remove sgp.hover_candidate
scoreboard players set @s sgp.hover_time 0
tag @s remove sgp.spawn_hovered

# Resolve the linked child directly, with both a type and a tight distance bound.
scoreboard players operation $link.to bs.in = @s bs.id
execute as @n[tag=sgp.spawn_tper_text,predicate=bs.link:link_equal,distance=..0.05,type=text_display] \
    run data merge entity @s {start_interpolation:0,interpolation_duration:4,transformation:{scale:[0.55f,0.55f,0.55f]}}

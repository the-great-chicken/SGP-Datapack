#> sgp.misc:diorama/check_for_giant_player

# Mark players currently INSIDE the miniature model
tag @a remove sgp.inside_model
$execute as @a[dx=$(mdx),dy=$(mdy),dz=$(mdz)] run tag @s add sgp.inside_model

# Mark players in the 3-block OUTER shell (excluding those inside)
tag @a remove sgp.around_model
$execute positioned ~-4 ~-4 ~-4 as @a[dx=$(mdx_end),dy=$(mdy_end),dz=$(mdz_end),tag=!sgp.inside_model] run tag @s add sgp.around_model

execute as @a[tag=sgp.has_giant_mannequin,tag=!sgp.around_model] run function sgp.misc:diorama/disappear {type:"giant"}

execute as @a[tag=sgp.around_model,tag=!sgp.has_giant_mannequin] \
    run function sgp.misc:diorama/on_player_around_model with storage sgp:data markers_lists.playable_map[0]
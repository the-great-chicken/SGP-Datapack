#> sgp.misc:player_mannequins/check_for_giant_player

# Mark players currently INSIDE the miniature model
tag @a remove sgp.inside_model
$execute as @a[dx=$(mdx),dy=$(mdy),dz=$(mdz)] run tag @s add sgp.inside_model

# Mark players in the 3-block OUTER shell (excluding those inside)
tag @a remove sgp.around_model
$execute positioned ~-3 ~-3 ~-3 as @a[dx=$(mdx_plus_6),dy=$(mdy_plus_6),dz=$(mdz_plus_6),tag=!sgp.inside_model] run tag @s add sgp.around_model

# Clean up giants for players who left the outer shell or walked into the diorama
execute as @a[tag=sgp.has_giant_mannequin,tag=!sgp.around_model] run function sgp.misc:player_mannequins/disappear {type:"giant"}

# Summon giant for new players entering the outer shell
execute as @a[tag=sgp.around_model,tag=!sgp.has_giant_mannequin] run function sgp.misc:player_mannequins/on_player_around_model
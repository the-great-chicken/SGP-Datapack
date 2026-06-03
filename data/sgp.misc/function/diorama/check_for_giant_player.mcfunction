#> sgp.misc:diorama/check_for_giant_player

# Mark players currently INSIDE the miniature model
tag @a remove sgp.inside_current_model
$execute as @a[dx=$(mdx),dy=$(mdy),dz=$(mdz)] run tag @s add sgp.inside_current_model

# Mark players in the 3-block OUTER shell (excluding those inside)
tag @a remove sgp.around_current_model
$execute positioned ~-4 ~-4 ~-4 as @a[dx=$(mdx_end),dy=$(mdy_end),dz=$(mdz_end),tag=!sgp.inside_current_model] run tag @s add sgp.around_current_model

tag @a[tag=sgp.around_current_model] add sgp.around_model

$execute as @a[tag=sgp.has_giant_mannequin_$(id),tag=!sgp.around_current_model] run function sgp.misc:diorama/disappear {type:"giant", id:$(id)}


scoreboard players operation $link.to bs.in = @s bs.id

$execute as @a[tag=sgp.around_current_model,tag=!sgp.has_giant_mannequin_$(id)] \
    at @e[predicate=bs.link:link_equal,tag=sgp.marker,name=playable_map,limit=1,type=marker] \
        run function sgp.misc:diorama/on_player_around_model {id:$(id)}
#> sgp.diorama:scale_down_anim/step

scoreboard players remove @s sgp.anim_timer 1

execute store result storage sgp:macro diorama.scale_down_anim.id int 1 \
    run scoreboard players get @s sgp.id

execute if score @s sgp.anim_timer matches ..0 \
    run function sgp.diorama:scale_down_anim/end_from_target with storage sgp:macro diorama.scale_down_anim
    
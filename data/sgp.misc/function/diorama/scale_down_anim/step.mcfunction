#> sgp.misc:diorama/scale_down_anim/step

scoreboard players remove @s sgp.anim_timer 1

execute store result storage sgp:macro diorama/scale_down_anim.id int 1 \
    run scoreboard players get @s bs.id
execute store result storage sgp:macro diorama/scale_down_anim.scale double 0.0625 \
    run scoreboard players get @s sgp.anim_timer

execute if score @s sgp.anim_timer matches ..0 \
    run function sgp.misc:diorama/scale_down_anim/end with storage sgp:macro diorama/scale_down_anim
#> sgp.majeurs:protect/dispatch
#
# Dispatch the players evenly between the two teams, by calling itself until
# no players are left without a team

execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_bleu",limit=1] \
    facing entity @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] eyes \
        positioned ^ ^ ^2 \
            as @r[distance=5..,tag=sgp.in_game] \
                run tp @s @e[type=marker,tag=sgp.marker,name="devenir_roi_bleu",limit=1]

execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_bleu",limit=1] \
    facing entity @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] eyes \
        positioned ^ ^ ^2 \
            as @r[distance=5..,tag=sgp.in_game] \
                run tp @s @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1]

execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_bleu",limit=1] \
    facing entity @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] eyes \
        positioned ^ ^ ^2 \
            if entity @a[distance=5..,tag=sgp.in_game] \
                run function sgp.majeurs:protect/dispatch
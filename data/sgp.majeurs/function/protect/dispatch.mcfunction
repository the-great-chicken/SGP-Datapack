#> sgp.majeurs:protect/dispatch
#
# Dispatch the players evenly between the two teams, by calling itself until
# no players are left without a team

function sgp.misc:selected_player/main {div:2, tag:sgp.select ,sign:'/'}

tp @a[tag=sgp.in_game,tag=sgp.select] @e[type=marker,tag=sgp.marker,name="devenir_roi_bleu",limit=1]
tp @a[tag=sgp.in_game,tag=!sgp.select] @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1]

tag @a[tag=sgp.select] remove sgp.select
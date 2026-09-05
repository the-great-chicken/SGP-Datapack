#> sgp.majeurs:protect/dispatch
#
# Split the round participants between the two teams and move them to their selection rooms.

function sgp.misc:selected_player/main {div:2,tag:sgp.protect.blue_team,sign:"/",add:0}

team join sgp.bleue @a[tag=sgp.major_participant,tag=sgp.protect.blue_team]
team join sgp.rouge @a[tag=sgp.major_participant,tag=!sgp.protect.blue_team]
tp @a[team=sgp.bleue] @e[tag=sgp.marker,name="devenir_roi_bleu",limit=1,type=marker]
tp @a[team=sgp.rouge] @e[tag=sgp.marker,name="devenir_roi_rouge",limit=1,type=marker]

tag @a remove sgp.protect.blue_team

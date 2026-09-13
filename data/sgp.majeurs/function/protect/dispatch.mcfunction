#> sgp.majeurs:protect/dispatch
#
# Split the round participants between the two teams and move them to their selection rooms.

team join sgp.rouge @a[tag=sgp.major_participant]
execute store result score #protect_blue_count sgp.dummy if entity @a[tag=sgp.major_participant]
scoreboard players operation #protect_blue_count sgp.dummy /= 2 sgp.dummy
execute store result storage sgp:data temp.protect_dispatch.count int 1 run scoreboard players get #protect_blue_count sgp.dummy
execute if score #protect_blue_count sgp.dummy matches 1.. run function sgp.majeurs:protect/dispatch_blue with storage sgp:data temp.protect_dispatch

tp @a[tag=sgp.major_participant,team=sgp.bleue] @e[tag=sgp.marker,name="devenir_roi_bleu",limit=1,type=marker]
tp @a[tag=sgp.major_participant,team=sgp.rouge] @e[tag=sgp.marker,name="devenir_roi_rouge",limit=1,type=marker]

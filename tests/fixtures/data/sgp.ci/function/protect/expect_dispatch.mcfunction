#> sgp.ci:protect/expect_dispatch
# `{red, blue: nonnegative int}`
#
# Expected participant counts and destinations, independent of random membership.

execute store result score #ci.protect.red sgp.dummy if entity @a[tag=sgp.major_participant,team=sgp.rouge]
execute store result score #ci.protect.blue sgp.dummy if entity @a[tag=sgp.major_participant,team=sgp.bleue]
$assert score #ci.protect.red sgp.dummy matches $(red)
$assert score #ci.protect.blue sgp.dummy matches $(blue)
execute at @e[tag=sgp.ci.protect,name=devenir_roi_rouge,limit=1,type=marker] run assert not entity @a[tag=sgp.major_participant,team=sgp.rouge,distance=0.1..]
execute at @e[tag=sgp.ci.protect,name=devenir_roi_bleu,limit=1,type=marker] run assert not entity @a[tag=sgp.major_participant,team=sgp.bleue,distance=0.1..]

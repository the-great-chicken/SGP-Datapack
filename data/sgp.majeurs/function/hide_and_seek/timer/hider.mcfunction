data modify storage smithed.actionbar:input message set value { \
    json:'[{"text": "vous avez "},{"score":{"name":"#hider","objective":"sgp.timer"}},{"text": " secondes pour vous cacher"}]', \
    priority:'notification' \
    }
execute as @a[team=sgp.hider] run function #smithed.actionbar:message

scoreboard players remove #hider sgp.timer 1
execute unless score #hider sgp.timer matches ..0 run function #bs.schedule:schedule {with:{command:"function sgp.majeurs:hide_and_seek/timer/hider",time:1,unit:"s"}}
execute if score #hider sgp.timer matches ..0 as @a[team=sgp.hider] run function sgp.majeurs:hide_and_seek/timer/end {role:'hider'}
title @a[team=sgp.hider] actionbar [{"text": "vous avez "},{"score":{"name":"#hider","objective":"sgp.timer"}},{"text": " secondes pour vous cacher"}]
scoreboard players remove #hider sgp.timer 1
execute unless score #hider sgp.timer matches ..0 run function #bs.schedule:schedule {with:{command:"function sgp.majeurs:hide_and_seek/timer/hider",time:1,unit:"s"}}
execute if score #hider sgp.timer matches ..0 as @a[team=sgp.hider] run function sgp.majeurs:hide_and_seek/timer/end {role:'hider'}
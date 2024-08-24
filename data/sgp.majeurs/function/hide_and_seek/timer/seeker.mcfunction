title @a[team=sgp.seeker] title [{"text": "vous pourrez chasser dans "},{"score":{"name":"#seeker","objective":"sgp.timer"}}]
scoreboard players remove #seeker sgp.timer 1
execute unless score #seeker sgp.timer matches ..0 run function #bs.schedule:schedule {with:{command:"function sgp.majeurs:hide_and_seek/timer/seeker",time:1,unit:"s"}}
execute if score #seeker sgp.timer matches ..0 as @a[team=sgp.seeker] run function sgp.majeurs:hide_and_seek/timer/end {role:'seeker'}
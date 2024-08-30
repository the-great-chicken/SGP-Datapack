#> sgp.majeurs:hide_and_seek/timer/become_seeker
#
# This function is called every second to update the timer of the new seeker.

title @s title [{"text": "vous pourrais chasser dans "},{"score":{"name":"@s","objective":"sgp.timer"}}]

execute unless score @s sgp.timer matches ..0 run function #bs.schedule:schedule {with:{command:"function sgp.majeurs:hide_and_seek/timer/become_seeker",time:1,unit:"s"}}
execute if score @s sgp.timer matches ..0 run function sgp.majeurs:hide_and_seek/timer/end {role:'become_seeker'}
scoreboard players remove @s sgp.timer 1
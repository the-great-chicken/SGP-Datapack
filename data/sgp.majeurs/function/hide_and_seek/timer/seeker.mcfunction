#> sgp.majeurs:hide_and_seek/timer/seeker
#
# This function is called every second to update the timer of the seeker.


title @a[tag=sgp.seeker] title [{"text": "La Chasse commence dans "},{"score":{"name":"#seeker","objective":"sgp.timer"}},"s"]


execute unless score #seeker sgp.timer matches ..0 run schedule function sgp.majeurs:hide_and_seek/timer/seeker 1s

execute if score #seeker sgp.timer matches ..0 as @a[team=sgp.seeker] run function sgp.majeurs:hide_and_seek/timer/end {role:'seeker'}

scoreboard players remove #seeker sgp.timer 1

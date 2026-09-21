#> sgp.bench:scenarios/events/major_hide_and_seek/clear
function #bs.schedule:cancel_all {with:{id:"hide_and_seek"}}
schedule clear sgp.majeurs:hide_and_seek/_start
schedule clear sgp.majeurs:hide_and_seek/_stop
schedule clear sgp.majeurs:hide_and_seek/timer/seeker
schedule clear sgp.majeurs:hide_and_seek/timer/hider
schedule clear sgp.majeurs:hide_and_seek/timer/glow
schedule clear sgp.majeurs:hide_and_seek/timer/glow_announce
schedule clear sgp.misc:second
scoreboard players set #second sgp.timer 0
kill @e[tag=sgp.bench.hns,type=marker]
scoreboard players set #rounds sgp.dummy 0
team empty sgp.hider
team empty sgp.seeker

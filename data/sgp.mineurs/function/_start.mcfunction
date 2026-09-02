#> sgp.mineurs:_start

tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Activation des Événements Mineurs", color:green, bold:true}]
scoreboard players set #events_mineurs_actifs sgp.dummy 1
scoreboard players set #events_mineurs sgp.timer 0
scoreboard players set #events_mineurs_seconds sgp.timer 0

function sgp.mineurs:common/roll_time_event
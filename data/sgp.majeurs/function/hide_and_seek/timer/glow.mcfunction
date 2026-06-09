#> sgp.majeurs:hide_and_seek/timer/glow

execute unless entity @a[tag=sgp.hider] run return 0

effect give @a[tag=sgp.hider] glowing 2 1 true
tellraw @a[tag=sgp.in_game] {text:"Toutes les volailles sont maintenant visibles pendant 2s",color:red}
schedule function sgp.majeurs:hide_and_seek/timer/glow 30s
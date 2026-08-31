#> sgp.majeurs:hide_and_seek/timer/glow

execute unless entity @a[predicate=sgp.majeurs:hide_and_seek/ongoing] run return 0

effect give @a[tag=sgp.hider] glowing 3 1 true
tellraw @a[tag=sgp.in_game] {text:"Toutes les volailles sont maintenant visibles pendant 3s",color:red}
schedule function sgp.majeurs:hide_and_seek/timer/glow_announce 20s
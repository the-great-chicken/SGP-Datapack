#> sgp.majeurs:hide_and_seek/timer/glow_announce

execute unless predicate sgp.majeurs:hide_and_seek/ongoing run return 0

tellraw @a[tag=sgp.in_game] {text:"Toutes les volailles seront visible dans 5s !",color:red}
schedule function sgp.majeurs:hide_and_seek/timer/glow 5s
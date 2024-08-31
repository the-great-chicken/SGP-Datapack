effect give @a[tag=sgp.hider] glowing 2 1 true
tellraw @a[tag=sgp.in_game] {"text":"tous les volaille sont maintenant visibles pendant 2s","color":"red"}
execute if entity @a[tag=sgp.hider] run schedule function sgp.majeurs:hide_and_seek/timer/glow 30s
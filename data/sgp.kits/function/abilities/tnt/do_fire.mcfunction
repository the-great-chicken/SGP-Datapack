#> sgp.kits:abilities/tnt/do_fire

scoreboard players remove @s sgp.timer 1
execute if score @s sgp.timer matches ..0 run return run kill @s

execute if entity @s[tag=sgp.fire_explosion_bigger] run return run function sgp.kits:abilities/tnt/do_bigger_fire

particle flame ~ ~ ~ 1.5 1.5 1.5 0 10
particle lava ~ ~ ~ 1.5 1.5 1.5 0 1
execute as @a[tag=sgp.in_game,tag=!sgp.peaceful,distance=..3.5] run damage @s 2 on_fire

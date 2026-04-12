scoreboard players remove @s sgp.timer 1
execute if score @s sgp.timer matches ..0 run return run kill @s
execute unless entity @s[tag=sgp.fire_explosion_bigger] at @s run particle flame ~ ~ ~ 1.5 1.5 1.5 0 10
execute unless entity @s[tag=sgp.fire_explosion_bigger] at @s run particle lava ~ ~ ~ 1.5 1.5 1.5 0 1
execute unless entity @s[tag=sgp.fire_explosion_bigger] at @s as @a[tag=sgp.in_game,tag=!sgp.peaceful,distance=..3.5] run damage @s 2 on_fire

execute if entity @s[tag=sgp.fire_explosion_bigger] at @s run particle flame ~ ~ ~ 3 3 3 0 50
execute if entity @s[tag=sgp.fire_explosion_bigger] at @s run particle soul_fire_flame ~ ~ ~ 3 3 3 0 5
execute if entity @s[tag=sgp.fire_explosion_bigger] at @s run particle copper_fire_flame ~ ~ ~ 3 3 3 0 3
execute if entity @s[tag=sgp.fire_explosion_bigger] at @s run particle lava ~ ~ ~ 3 3 3 0 10
execute if entity @s[tag=sgp.fire_explosion_bigger] at @s as @a[tag=sgp.in_game,tag=!sgp.peaceful,distance=..6.5] run damage @s 2 on_fire
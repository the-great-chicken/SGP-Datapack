#> sgp.kits:abilities/tnt/do_bigger_fire

particle flame ~ ~ ~ 3 3 3 0 50
particle soul_fire_flame ~ ~ ~ 3 3 3 0 5
particle copper_fire_flame ~ ~ ~ 3 3 3 0 3
particle lava ~ ~ ~ 3 3 3 0 10
execute as @a[tag=sgp.in_game,tag=!sgp.peaceful,distance=..6.5] run damage @s 2 on_fire
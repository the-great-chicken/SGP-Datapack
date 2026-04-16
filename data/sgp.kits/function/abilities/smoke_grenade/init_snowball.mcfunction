#> sgp.kits:abilities/smoke_grenade/init_snowball

execute on passengers run scoreboard players operation @s sgp.id = #smoke_temp sgp.id

execute positioned as @s run tp @s ~ ~ ~ ~ ~

execute store result entity @s Motion[0] double 0.0015 run data get entity @e[tag=sgp.aim_vector,limit=1,x=-3,y=-3,z=-3,dx=9,dy=9,dz=9,type=marker] Pos[0] 1000
execute store result entity @s Motion[1] double 0.0015 run data get entity @e[tag=sgp.aim_vector,limit=1,x=-3,y=-3,z=-3,dx=9,dy=9,dz=9,type=marker] Pos[1] 1000
execute store result entity @s Motion[2] double 0.0015 run data get entity @e[tag=sgp.aim_vector,limit=1,x=-3,y=-3,z=-3,dx=9,dy=9,dz=9,type=marker] Pos[2] 1000

tag @s remove sgp.new
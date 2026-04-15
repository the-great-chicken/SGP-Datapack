#> sgp.kits:abilities/smoke_grenade/start

scoreboard players set @s sgp.cooldown_ability 400

# Summons a marker at 0 0 0, but 1 block in the direction where the player is looking at. That gives vectors of where the player is aiming as the marker's coordinates
execute rotated as @s positioned 0.0 0.0 0.0 run summon marker ^ ^ ^1 {Tags:["sgp.aim_vector"]}

# Projectile with an item display as passenger for custom visual
execute anchored eyes positioned ^ ^ ^1 run summon snowball ~ ~ ~ {Item:{id:"minecraft:snowball", count:1, components:{"minecraft:item_model":"sgp.kits:empty_model"}}, Tags:["sgp.smoke_grenade", "sgp.new"], Passengers:[{id:"minecraft:item_display", Tags:["sgp.smoke_visual"], item:{id:"minecraft:snowball", count:1}, item_display:"fixed", transformation:{scale:[3.0f, 3.0f, 3.0f],right_rotation:{axis:[0,0,0],angle:0},left_rotation:{axis:[0,0,0],angle:0},translation:[0,-0.5f,-1f]}}]}

execute rotated as @s as @e[tag=sgp.new,distance=..3,limit=1,type=snowball] run function sgp.kits:abilities/smoke_grenade/init_snowball

kill @e[tag=sgp.aim_vector,limit=1,x=-3,y=-3,z=-3,dx=9,dy=9,dz=9,type=marker]
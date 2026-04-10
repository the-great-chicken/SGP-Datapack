#> sgp.kits:abilities/smoke_grenade/launch

scoreboard players set @s sgp.cooldown_ability 200

# Summons a marker at 0 0 0, but 1 block in the direction where the player is looking at. That gives vectors of where the player is aiming as the marker's coordinates
execute rotated as @s positioned 0.0 0.0 0.0 run summon marker ^ ^ ^1 {Tags:["sgp.aim_vector"]}

# Projectile with an item display as passenger for custom visual
execute anchored eyes positioned ^ ^ ^1 run summon snowball ~ ~ ~ {Item:{id:"minecraft:snowball", count:1, components:{"minecraft:item_model":"sgp.kits:empty_model"}}, Tags:["sgp.smoke_grenade", "sgp.just_fired"], Passengers:[{id:"minecraft:item_display", Tags:["sgp.smoke_visual"], item:{id:"minecraft:snowball", count:1}, item_display:"fixed", transformation:{scale:[3.0f, 3.0f, 3.0f],right_rotation:{axis:[0,0,0],angle:0},left_rotation:{axis:[0,0,0],angle:0},translation:[0,-0.5f,-1f]}}]}

# Tp the arrow to itself but rotate it as the player
execute rotated as @s as @e[type=snowball,tag=sgp.just_fired,limit=1] positioned as @s run tp @s ~ ~ ~ ~ ~

# Copy the aim vector into the projectile's motion
execute store result entity @e[type=snowball,tag=sgp.just_fired,limit=1] Motion[0] double 0.0015 run data get entity @e[type=marker,tag=sgp.aim_vector,limit=1] Pos[0] 1000
execute store result entity @e[type=snowball,tag=sgp.just_fired,limit=1] Motion[1] double 0.0015 run data get entity @e[type=marker,tag=sgp.aim_vector,limit=1] Pos[1] 1000
execute store result entity @e[type=snowball,tag=sgp.just_fired,limit=1] Motion[2] double 0.0015 run data get entity @e[type=marker,tag=sgp.aim_vector,limit=1] Pos[2] 1000

tag @e[type=snowball,tag=sgp.just_fired] remove sgp.just_fired
kill @e[type=marker,tag=sgp.aim_vector]
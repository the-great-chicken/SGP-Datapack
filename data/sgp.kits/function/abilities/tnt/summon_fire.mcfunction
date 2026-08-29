#> sgp.kits:abilities/tnt/start_fire

summon marker ~ ~ ~ {Tags:["sgp.marker", "sgp.fire_explosion", "sgp.new"]}
scoreboard players set @n[tag=sgp.new,distance=..0.1,limit=1,type=marker] sgp.timer 100
scoreboard players operation @n[tag=sgp.new,distance=..0.1,limit=1,type=marker] sgp.damage_owner = @s sgp.damage_owner

execute store result score #fire_explosion_roll sgp.dummy run random value 1..15
execute if score #fire_explosion_roll sgp.dummy matches 10 run tag @n[tag=sgp.new,distance=..0.1,limit=1,type=marker] add sgp.fire_explosion_bigger
execute if score #fire_explosion_roll sgp.dummy matches 10 run playsound sgp.kits:abilities/allumer_le_feu master @a ~ ~ ~ 1 1

tag @e[tag=sgp.new,distance=..0.1,type=marker] remove sgp.new

kill @n[tag=sgp.tnt_interaction,distance=..5,limit=1,type=interaction]

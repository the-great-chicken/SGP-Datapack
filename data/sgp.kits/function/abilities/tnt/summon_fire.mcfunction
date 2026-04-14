#> sgp.kits:abilities/tnt/summon_fire

summon marker ~ ~ ~ {Tags:["sgp.marker", "sgp.fire_explosion"]}
scoreboard players set @e[tag=sgp.fire_explosion,distance=..0.1,limit=1,type=marker] sgp.timer 100

execute store result score #fire_explosion_roll sgp.dummy run random value 1..15
execute if score #fire_explosion_roll sgp.dummy matches 10 run tag @e[tag=sgp.fire_explosion,distance=..0.1,limit=1,type=marker] add sgp.fire_explosion_bigger
execute if score #fire_explosion_roll sgp.dummy matches 10 run playsound sgp.kits:abilities/allumer_le_feu master @a ~ ~ ~ 1 1

kill @n[tag=sgp.tnt_interaction,distance=..5,limit=1,type=interaction]
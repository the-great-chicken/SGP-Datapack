execute at @n[type=tnt,nbt={fuse:1s}] run summon marker ~ ~ ~ {Tags:["sgp.marker", "sgp.fire_explosion"]}
execute at @n[type=tnt,nbt={fuse:1s}] run scoreboard players set @n[type=marker,tag=sgp.fire_explosion] sgp.timer 100

execute store result score #fire_explosion_roll sgp.dummy run random value 1..10
execute if score #fire_explosion_roll sgp.dummy matches 10 at @n[type=tnt,nbt={fuse:1s}] run tag @n[type=marker,tag=sgp.fire_explosion] add sgp.fire_explosion_bigger
execute if score #fire_explosion_roll sgp.dummy matches 10 at @n[type=tnt,nbt={fuse:1s}] run playsound sgp.kits:abilities/allumer_le_feu master @a ~ ~ ~ 1 1
#> sgp.kits:abilities/cleave/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.cleave.cooldown

# Cool sound (to be modified)
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 0.5
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 0.6
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 0.7
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 0.8
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 0.9
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 1
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 1.1
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 1.2
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 1.3
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 1.4
playsound minecraft:entity.player.attack.sweep player @a[tag=sgp.in_game] ~ ~ ~ 1 1.5

# Summon the giant sweep display entity 2 blocks in front of the player
execute rotated ~ 0 run summon item_display ^ ^-0.5 ^3.5 {Tags:["sgp.giant_sweep", "sgp.giant_sweep_new"], item:{id:"minecraft:paper", count:1, components:{"minecraft:item_model":"sgp.kits:giant_sweep_0"}}, transformation:{translation:[0f,0f,0f], scale:[9,9,9], left_rotation:[0.707f, 0f, 0f, 0.707f], right_rotation:[0f,0f,0f,1f]}}

execute rotated as @s as @e[tag=sgp.giant_sweep_new,distance=..5,type=item_display] run function sgp.kits:abilities/cleave/setup_display

# Target all entities within 5 blocks and run the damage check on them
tag @s add sgp.attacker
execute as @a[tag=sgp.in_game,tag=!sgp.peaceful,distance=0.1..5] at @s run function sgp.kits:abilities/cleave/check
tag @s remove sgp.attacker
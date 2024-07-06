execute as @a[scores={sgp.reflexes_joueur=1..},tag=!sgp.reflexes_check] run tag @s add sgp.reflexes_check
execute as @a[tag=!sgp.reflexes_check] at @s run playsound minecraft:entity.experience_orb.pickup ambient @s ~ ~ ~ 10 0.5
scoreboard players add #reflexes_ticks sgp.timer 1
execute if score #reflexes_ticks sgp.timer matches 100 run function sgp.mineurs:reflexes/end
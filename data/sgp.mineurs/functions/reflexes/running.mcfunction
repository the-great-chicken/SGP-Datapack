execute as @a[scores={sgp.reflexes_joueur=1..},tag=!reflexes_check] run tag @s add reflexes_check
execute as @a[tag=!reflexes_check] at @s run playsound minecraft:entity.experience_orb.pickup ambient @s ~ ~ ~ 10 0.5
scoreboard players add #reflexes_ticks sgp.timer 1
execute if score #reflexes_ticks sgp.timer matches 100 run function sgp.mineurs:reflexes/end
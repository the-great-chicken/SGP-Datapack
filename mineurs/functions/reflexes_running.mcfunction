execute as @a[scores={reflexes_joueur=1..},tag=!reflexes_check] run tag @s add reflexes_check
execute as @a[tag=!reflexes_check] at @s run playsound minecraft:entity.experience_orb.pickup ambient @s ~ ~ ~ 10 0.5
scoreboard players add reflexes_ticks timer_second 1
execute if score reflexes_ticks timer_second < 100 test run schedule function mineurs:reflexes_running 1
execute if score reflexes_ticks timer_second matches 100 in minisjeux_crea run function mineurs:reflexes_end
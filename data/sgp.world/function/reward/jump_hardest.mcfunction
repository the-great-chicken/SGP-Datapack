#> sgp.world:reward/jump_hardest
# 
# Check if a player triggered the reward of the hardest jump,
# and gives it to him if so

execute at @e[type=marker,tag=sgp.marker,name="jump_hardest"] as @s[scores={sgp.jump_hardest_done=0},distance=..0.5] run scoreboard players enable @s sgp.jump_hardest_done
execute at @e[type=marker,tag=sgp.marker,name="jump_hardest"] as @s[scores={sgp.jump_hardest_done=0},distance=..0.5] run scoreboard players set @s sgp.jump_hardest_done 1
execute at @e[type=marker,tag=sgp.marker,name="jump_hardest"] as @s[scores={sgp.jump_hardest_done=1},distance=0.5..] run trigger sgp.jump_hardest_done set 0
execute as @s[scores={sgp.jump_hardest_done=2}] run tellraw @s ["Tu viens de débloquer la Trainée de Particule ",{"text":"Marine", "bold":true, "color": "blue"}," !\nVa dans la Salle des ",{"text":"Cosmétiques", "color":"light_purple", "bold":true}," depuis la Salle d'Accueil pour l'activer !"]
execute as @s[scores={sgp.jump_hardest_done=2}] run scoreboard players set @s sgp.marine_particle_unlocked 1
execute as @s[scores={sgp.jump_hardest_done=2}] at @s run summon firework_rocket ~ ~ ~ {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Explosions:[{Type:1, Flicker:1, Trail:1, Colors:[I; 2437522]}], Flight:1}}}}
execute as @s[scores={sgp.jump_hardest_done=2}] run scoreboard players set @s sgp.jump_hardest_done 3
#> sgp.world:reward/jump_hardest
# 
# Check if a player triggered the reward of the hardest jump,
# and gives it to him if so

execute at @e[type=marker,tag=sgp.marker,name="jump_hardest",limit=1] as @s[scores={sgp.jump_hardest_done=0},distance=..0.5] run scoreboard players enable @s sgp.jump_hardest_done
execute at @e[type=marker,tag=sgp.marker,name="jump_hardest",limit=1] as @s[scores={sgp.jump_hardest_done=0},distance=..0.5] run scoreboard players set @s sgp.jump_hardest_done 1

execute at @e[type=marker,tag=sgp.marker,name="jump_hardest",limit=1] as @s[scores={sgp.jump_hardest_done=1},distance=0.5..] run trigger sgp.jump_hardest_done set 0


execute as @s[scores={sgp.jump_hardest_done=2}] \
    run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu viens de débloquer la Trainée de Particule ", "color":"aqua"}, {"text":"Marine", "bold":true, "color": "blue"},{"text":" !\n\
        Va dans la Salle des ", "color":"aqua"}, {"text":"Cosmétiques", "color":"light_purple", "bold":true},{"text":" depuis la Salle d'Accueil pour l'activer !", "color":"aqua"}]
        
execute as @s[scores={sgp.jump_hardest_done=2}] run scoreboard players set @s sgp.marine_particle_unlocked 1
execute as @s[scores={sgp.jump_hardest_done=2}] at @s run summon firework_rocket ~ ~ ~ {LifeTime:20, FireworksItem:{id:"firework_rocket",count:1,components:{fireworks:{explosions:[{shape:"large_ball",has_twinkle:true,has_trail:true,colors:[I;2437522]}],flight_duration:1}}}}
execute as @s[scores={sgp.jump_hardest_done=2}] run scoreboard players set @s sgp.jump_hardest_done 3
#> sgp.world:reward/jump_diff_2
# 
# Check if a player triggered the reward of the difficulty 2 jump,
# and gives it to him if so

execute at @e[type=marker,tag=sgp.marker,name="jump_diff_2"] as @s[scores={sgp.jump_diff_2_done=0},distance=..2] run scoreboard players enable @s sgp.jump_diff_2_done
execute at @e[type=marker,tag=sgp.marker,name="jump_diff_2"] as @s[scores={sgp.jump_diff_2_done=0},distance=..2] run scoreboard players set @s sgp.jump_diff_2_done 1

execute at @e[type=marker,tag=sgp.marker,name="jump_diff_2"] as @s[scores={sgp.jump_diff_2_done=1},distance=2..] run trigger sgp.jump_diff_2_done set 0


execute as @s[scores={sgp.jump_diff_2_done=2}] \
    run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu viens de débloquer le Kill Effect ", "color":"aqua"}, {"text":"Splash", "bold":true, "color": "blue"},{"text":" !\n \
        Va dans la Salle des ", "color":"aqua"}, {"text":"Cosmétiques", "color":"light_purple", "bold":true}, {"text":" depuis la Salle d'Accueil pour l'activer !", "color":"aqua"}]

execute as @s[scores={sgp.jump_diff_2_done=2}] run scoreboard players set @s sgp.splash_kill_unlocked 1
execute as @s[scores={sgp.jump_diff_2_done=2}] at @s run summon firework_rocket ~ ~ ~ {LifeTime:20,FireworksItem:{id:"firework_rocket",count:1,components:{fireworks:{explosions:[{shape:"large_ball",has_twinkle:true,has_trail:true,colors:[I;2437522]}],flight_duration:1}}}}
execute as @s[scores={sgp.jump_diff_2_done=2}] run scoreboard players set @s sgp.jump_diff_2_done 3
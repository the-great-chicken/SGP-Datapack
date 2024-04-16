execute as @s[scores={jump_diff_2_done=0},x=2429.5,y=240.5,z=2179.5,distance=..2] run scoreboard players enable @s jump_diff_2_done
execute as @s[scores={jump_diff_2_done=0},x=2429.5,y=240.5,z=2179.5,distance=..2] run scoreboard players set @s jump_diff_2_done 1
execute as @s[scores={jump_diff_2_done=1},x=2429.5,y=240.5,z=2179.5,distance=2..] run trigger jump_diff_2_done set 0
execute as @s[scores={jump_diff_2_done=2}] run tellraw @s ["",{"text":"Vous venez de débloquer le Kill Effect "},{"text":"Splash","bold":true, "color": "blue"},{"text":" !\nAllez dans la Salle des ", "color": "white"},{"text":"Cosmétiques","color":"light_purple","bold":true},{"text":" depuis la Salle d'Accueil pour l'activer !"}]
execute as @s[scores={jump_diff_2_done=2}] run scoreboard players set @s splash_kill_unlocked 1
execute as @s[scores={jump_diff_2_done=2}] at @s run summon firework_rocket ~ ~ ~ {LifeTime:20,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;2437522]}],Flight:1}}}}
execute as @s[scores={jump_diff_2_done=2}] run scoreboard players set @s jump_diff_2_done 3 
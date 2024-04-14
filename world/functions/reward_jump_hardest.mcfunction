execute as @s[scores={jump_hardest_done=0},x=2536.5,y=252.5,z=2172.5,distance=..0.5] run scoreboard players enable @s jump_hardest_done
execute as @s[scores={jump_hardest_done=0},x=2536.5,y=252.5,z=2172.5,distance=..0.5] run scoreboard players set @s jump_hardest_done 1
execute as @s[scores={jump_hardest_done=1},x=2536.5,y=252.5,z=2172.5,distance=0.5..] run trigger jump_hardest_done set 0
execute as @s[scores={jump_hardest_done=2}] run tellraw @s [{"text":"Vous venez de débloquer la Trainée de Particule "},{"text":"Marine","bold":true, "color": "blue"},{"text":" !\nAllez dans la Salle des ","bold":false, "color": "white"},{"text":"Cosmétiques","color":"light_purple","bold":true},{"text":" depuis la Salle d'Accueil pour l'activer !","bold":false}]
execute as @s[scores={jump_hardest_done=2}] run scoreboard players set @s marine_particle_unlocked 1
execute as @s[scores={jump_hardest_done=2}] at @s run summon firework_rocket ~ ~ ~ {LifeTime:20,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;2437522]}],Flight:1}}}}
execute as @s[scores={jump_hardest_done=2}] run scoreboard players set @s jump_hardest_done 3 
$execute if score @s $(particle)_particle_unlocked matches 1 run tag @s add $(particle)_particle
$execute if score @s $(particle)_particle_unlocked matches 1 run tellraw @s [{"text":"Tu as sélectionné la Trainée de Particules "},{"text":"$(particule)", "color":"$(couleur)", "bold":true}]
$scoreboard players enable @s veut_$(particle)
$scoreboard players set @s veut_$(particle) 0
$execute as @s unless score @s $(particle)_particle_unlocked matches 1 run tellraw @s [{"text":"Tu n'as pas encore débloqué la Trainée de Particules ", "color":"red"},{"text":"$(particule)", "bold":true, "color":"$(couleur)"},{"text":" !\n", "color":"red"},{"text":"Va parler au ", "color":"aqua"},{"text":"Corbeautaniste","bold":true, "color":"green"},{"text":" pour en savoir plus.", "color":"aqua"}]
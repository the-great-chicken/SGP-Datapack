$execute if score @s sgp.$(particle)_particle_unlocked matches 1 run tag @s add $(particle)_particle
$execute if score @s sgp.$(particle)_particle_unlocked matches 1 run tellraw @s ["Tu as sélectionné la Trainée de Particules ",{"text":"$(particule)", "color":"$(couleur)", "bold":true}]
$scoreboard players enable @s sgp.veut_$(particle)
$scoreboard players set @s sgp.veut_$(particle) 0
$execute as @s unless score @s sgp.$(particle)_particle_unlocked matches 1 run tellraw @s [{"text":"Tu n'as pas encore débloqué la Trainée de Particules ", "color":"red"},{"text":"$(particule)", "bold":true, "color":"$(couleur)"}," !\n",{"text":"Va parler au ", "color":"aqua"},{"text":"Corbeautaniste","bold":true, "color":"green"},{"text":" pour en savoir plus.", "color":"aqua"}]
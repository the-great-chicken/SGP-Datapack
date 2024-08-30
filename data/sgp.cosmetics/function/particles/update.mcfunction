#> sgp.cosmetics:particles/update
# `{particle, particule: formated_effect_name, couleur: minecraft_color}`
# 
# Checks if the player has unlocked the particle cloak, activating it or not

$execute if score @s sgp.$(particle)_particle_unlocked matches 1 run tag @s add sgp.$(particle)_particle
$execute if score @s sgp.$(particle)_particle_unlocked matches 1 \
    run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as sélectionné la Trainée de Particules ", "color":"aqua"}, {"text":"$(particule)", "color":"$(couleur)", "bold":true}]

$scoreboard players enable @s sgp.veut_$(particle)
$scoreboard players set @s sgp.veut_$(particle) 0

$execute as @s unless score @s sgp.$(particle)_particle_unlocked matches 1 \
    run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu n'as pas encore débloqué la Trainée de Particules ", "color":"red"}, {"text":"$(particule)", "bold":true, "color":"$(couleur)"}," !\n", \
        {"text":"Tu trouveras peut-être", "color":"aqua"}, {"text":"une façon","bold":true, "color":"green"}, {"text":"de la débloquer durant la soirée", "color":"aqua"}]
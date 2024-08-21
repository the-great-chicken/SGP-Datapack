#> sgp.cosmetics:kill_effects/update
# `{effect, effet: formated_particle_name, couleur: minecraft_color}`
# 
# Checks if the player has unlocked the kill effect, activating it or not

$execute if score @s sgp.$(effect)_kill_unlocked matches 1 run function sgp.cosmetics:kill_effects/reset
$execute if score @s sgp.$(effect)_kill_unlocked matches 1 run tag @s add sgp.$(effect)_kill
$execute if score @s sgp.$(effect)_kill_unlocked matches 1 run \
    tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Ton Kill Effect est maintenant ", "color":"aqua"}, {"text":"$(effect)", "color":"$(couleur)", "bold":true}]

$scoreboard players enable @s sgp.veut_kill_$(effect)
$scoreboard players set @s sgp.veut_kill_$(effect) 0

$execute unless score @s sgp.$(effect)_kill_unlocked matches 1 \
    run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu n'as pas encore débloqué le Kill Effect ", "color":"red"}, {"text":"$(effet)", "bold":true, "color":"$(couleur)"}," !\n", \
        {"text":"Tu trouveras peut-être ", "color":"aqua"}, {"text":"une façon", "bold":true, "color":"green"}, {"text":" de le débloquer durant la soirée !", "color":"aqua"}]
#> sgp.kits:misc/random_sub
# `{kit, kit_name, kit_color}`
# 
# Sub-function of the sgp.kits:misc/random function. Check if the player has unlocked the kit
# Give the kit if so, rerun the random function if not.

scoreboard players set @s sgp.veut_random 0
scoreboard players enable @s sgp.veut_random

$execute if score @s sgp.$(kit)_found matches 0 \
    run return run function sgp.kits:misc/random

$scoreboard players enable @s sgp.veut_$(kit)
$trigger sgp.veut_$(kit)
$tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as obtenu le kit ", "color":"aqua"}, {"text":"$(kit_name)", "color":"$(kit_color)", "bold":true}]
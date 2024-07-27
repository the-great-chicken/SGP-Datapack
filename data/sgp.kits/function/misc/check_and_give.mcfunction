#> sgp.kits:misc/check_and_give
# `{kit, kit_color, hint: json_text_component, hint_color}`
# 
# Checks if the player has unlocked the kit, giving it or not

$execute as @s[scores={sgp.$(kit)_found=3}] run function sgp.kits:give {kit:$(kit)}
$execute as @s[scores={sgp.$(kit)_found=0}] run function sgp.kits:unlocking/kit_not_found {kit:$(kit), kit_color:"$(kit_color)", hint:"$(hint)", hint_color:"$(hint_color)"}
$scoreboard players enable @s sgp.veut_$(kit)
$execute as @s[scores={$(kit)_found=3}] run function sgp.kits:collection/$(kit)
$execute as @s[scores={$(kit)_found=0}] run function sgp.kits:unlocking/kit_not_found {kit:$(kit), kit_color:"$(kit_color)", hint:"$(hint)", hint_color:"$(hint_color)"}
$scoreboard players enable @s veut_$(kit)
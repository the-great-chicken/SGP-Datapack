$execute as @s[scores={$(kit)_found=3}] run function kits:$(kit)
$execute as @s[scores={$(kit)_found=0}] run function kits:kit_not_found {kit:$(kit), kit_color:"$(kit_color)", hint:"$(hint)", hint_color:"$(hint_color)"}
$scoreboard players enable @s veut_$(kit)
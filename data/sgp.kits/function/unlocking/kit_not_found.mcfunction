#> sgp.kits:unlocking/kit_not_found
# `{kit, kit_color, hint, hint_color}`
# 
# Tells the player he hasn't unlocked the kit, and gives him a hint

$tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Débloque le kit ", "color":"red"}, {"text":"$(kit)", "bold":true, "color":"$(kit_color)"}, {"text":" en le trouvant dans la map !\n \
    Indice : ","color":"red"}, {"text":"$(hint)", "color":"$(hint_color)", "bold":true}]

$scoreboard players set @s sgp.veut_$(kit) 0
#> sgp.kits:check_and_give
# `{kit, kit_name: name to display, kit_color, hint: json_text_component, hint_color}`
# 
# Checks if the player has unlocked the kit, giving it or not

$execute if score @s sgp.$(kit)_found matches 3 run function sgp.kits:give {kit:$(kit)}
$execute if score @s sgp.$(kit)_found matches 3 run tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"Tu as obtenu le kit ", color:aqua}, {text:"$(kit_name)", color:$(kit_color), bold:true}]
$execute if score @s sgp.$(kit)_found matches 0 run tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"Débloque le kit ", color:red}, {text:"$(kit)", bold:true, color:"$(kit_color)"}, {text:" en le trouvant dans la map !\n Indice : ",color:red}, {text:"$(hint)", color:"$(hint_color)", bold:true}]
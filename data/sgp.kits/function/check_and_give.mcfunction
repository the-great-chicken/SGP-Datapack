#> sgp.kits:check_and_give
# `{kit, kit_name: name to display, kit_color, hint: json_text_component, hint_color}`
# 
# Checks if the player has unlocked the kit, giving it or not

$execute unless score @s sgp.$(kit)_found matches 1 run return \
    run tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, \
                    {translate:"Débloque le kit %s en le trouvant dans la map !\n Indice : %s",color:red, \
                        with:[{text:"$(kit)", bold:true, color:"$(kit_color)"},{text:"$(hint)", color:"$(hint_color)", bold:true}]}]

scoreboard players set #can_give sgp.dummy 0
$execute store result score #can_give sgp.dummy run function sgp.kits:can_give {kit:$(kit)}
execute unless score #can_give sgp.dummy matches 1.. run return 0

$function sgp.kits:give {kit:$(kit)}
$tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Tu as obtenu le kit ", color:aqua}, {text:"$(kit_name)", color:$(kit_color), bold:true}]
#> sgp.cosmetics:update
# `{effect, effect_name: string_to_display, color: minecraft_color, type: intensity|particle|kill, type_text: string_to_display}`
# 
# Checks if the player has unlocked the cosmetic, activating it or not


$execute store result score #interaction sgp.cosmetics.api run function sgp.cosmetics:api/equip/$(type)/$(effect)
$execute if score #interaction sgp.cosmetics.api matches 1 \
    run tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Tu as sélectionné $(type_text) ", color:aqua}, {text:"$(effect_name)", color:"$(color)", bold:true}]

$execute unless score #interaction sgp.cosmetics.api matches 1 \
    run tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Tu n'as pas encore débloqué $(type_text) ", color:red}, {text:"$(effect_name)", bold:true, color:"$(color)"}," !\n", \
        {text:"Tu trouveras peut-être ", color:aqua}, {text:"une façon", bold:true, color:green}, {text:" de débloquer ça durant la soirée", color:aqua}]

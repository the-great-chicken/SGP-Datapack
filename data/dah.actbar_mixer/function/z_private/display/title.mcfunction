$execute if data storage sgp:actionbar_hud overlay[0] \
    run title @s actionbar [{nbt:"overlay[].text",storage:"sgp:actionbar_hud",interpret:true,separator:"",bold:false},\
                            {nbt:"display_content[].text",storage:"dah:actbar",interpret:true,separator:$(separator),font:"minecraft:default"}]

$execute unless data storage sgp:actionbar_hud overlay[0] \
    run title @s actionbar [{nbt:"display_content[].text",storage:"dah:actbar",interpret:true,separator:$(separator)}]
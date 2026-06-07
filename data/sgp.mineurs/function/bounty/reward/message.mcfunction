#> sgp.mineurs:bounty/reward/message
#
# Send the reward message to the player

scoreboard players enable @s sgp.reward
tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text: "Choisis une récompense :", color: white}]
tellraw @s ["", \
    {color:dark_red, text:" [Force] ", hover_event:{action:show_text, value:[{text:"Donne "}, {text:"Force ", color:dark_red}, {text:"I pendant 2 minutes"}]}, click_event:{action:run_command, command:"/trigger sgp.reward set 1"}}, \
    {text: "/ ", color: white}, \
    {color:gold, text:"[Absorption] ", hover_event:{action:show_text, value:[{text:"Te donne 2 barres d' "}, {text:"Absorption ", color:gold}, {text:"permanent"}]}, click_event:{action:run_command,command:"/trigger sgp.reward set 2"}}, \
    {text: "/ ", color: white}, \
    {text:"[Boost de Vie] ", color:light_purple, hover_event:{action:show_text, value:[{text:"Donne 3 "}, {text:"❤ ", color:red}, {text:"supplémentaire jusqu'à ta prochaine mort"}]}, click_event:{action:run_command, command:"/trigger sgp.reward set 3"}}, \
    {text: "/ ", color: white}, \
    {text:"[Totem + Pomme Cheat] ", color:yellow, hover_event:{action:show_text, value:[{text:"Donne un "},{"translate": "item.minecraft.totem_of_undying", color: yellow}, {text:" et une "}, {"translate": "item.minecraft.enchanted_golden_apple", color: light_purple}]}, click_event:{action:run_command, command:"/trigger sgp.reward set 4"}}]
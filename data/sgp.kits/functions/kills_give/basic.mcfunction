#> sgp.kits:kills_give/basic
# `{give: minecraft_item, give_2: minecraft_item, actionbar: json_text_component, nb: [1,2,3]}`
# 
# Gives the item(s) and tells the player what reward(s) he got for his kill(s)

$give @s $(give)
$give @s $(give_2)
$data modify storage smithed.actionbar:input message set value {json:'[$(actionbar)]',priority:'notification'}
execute as @s run function #smithed.actionbar:message
$scoreboard players set @s sgp.kills_give_$(nb) 0
#> sgp.kits:kills_give/basic
# `{give: minecraft_item, give_2: minecraft_item, actionbar: json_text_component, nb: [1,2,3]}`
# 
# Gives the item(s) and tells the player what reward(s) they got for their kill(s)

$give @s $(give)
$give @s $(give_2)
$function sgp.misc:actionbar/reward {id:"sgp:reward_$(nb)", slot:$(nb), text:[$(actionbar)]}
$scoreboard players set @s sgp.kills_give_$(nb) 0
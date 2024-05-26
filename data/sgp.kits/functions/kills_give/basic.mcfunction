$give @s $(give)
$give @s $(give_2)
$data modify storage smithed.actionbar:input message set value {json:'[$(actionbar)]',priority:'notification'}
execute as @s run function #smithed.actionbar:message
$scoreboard players set @s sgp.kills_give_$(nb) 0
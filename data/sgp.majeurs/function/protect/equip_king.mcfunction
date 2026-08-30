#> sgp.majeurs:protect/equip_king
# `{side}`
#
# Give a selected king their event kit and move them to their team spawn.

function sgp.kits:give {kit:roi}
effect give @s minecraft:health_boost infinite 4 true
effect give @s minecraft:regeneration 2 10 true
item replace entity @s hotbar.2 with golden_apple[custom_name={text:"Pomme d'or",color:yellow,italic:false,bold:true},lore=[[{text:"Régénère jusqu'à 6",color:gray,italic:false},{text:"❤",color:red},{text:" + 2"},{text:"❤",color:yellow}]]] 12
$tp @s @e[tag=sgp.marker,name="protect_spawn_$(side)s",limit=1,type=marker]

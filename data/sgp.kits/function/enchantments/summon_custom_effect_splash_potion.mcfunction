# Copy the custom potion effects from the arrow to the splash potion
summon potion ~ ~0.5 ~ {Item:{id:"minecraft:splash_potion",count:1b,components:{"minecraft:potion_contents":{custom_effects:[]}}},Motion:[0.0,-10.0,0.0]}
data modify entity @e[type=potion,sort=nearest,limit=1] Item.components.minecraft:potion_contents.custom_effects set from entity @s item.components."minecraft:potion_contents".custom_effects
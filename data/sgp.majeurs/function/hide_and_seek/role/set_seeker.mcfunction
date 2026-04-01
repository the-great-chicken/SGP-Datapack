#> sgp.majeurs:hide_and_seek/role/set_seeker
#
# Set the seeker attribute for the role
team join sgp.seeker @s
tag @s add sgp.seeker
tellraw @s [{text:"Vous devez éliminer tous les Volailles",color:red}]
attribute @s attack_damage modifier add sgp.seeker 1000 add_value
function sgp.majeurs:hide_and_seek/stun/stun

#Set the armor
item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=11546150,enchantments={binding_curse:1},enchantment_glint_override=false,unbreakable={},tooltip_display={hidden_components:["attribute_modifiers","enchantments","unbreakable","dyed_color"]}]
item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=11546150,enchantments={binding_curse:1},enchantment_glint_override=false,unbreakable={},tooltip_display={hidden_components:["attribute_modifiers","enchantments","unbreakable","dyed_color"]}]
item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=11546150,enchantments={binding_curse:1},enchantment_glint_override=false,unbreakable={},tooltip_display={hidden_components:["attribute_modifiers","enchantments","unbreakable","dyed_color"]}]
item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=11546150,enchantments={binding_curse:1},enchantment_glint_override=false,unbreakable={},tooltip_display={hidden_components:["attribute_modifiers","enchantments","unbreakable","dyed_color"]}]


tp @s @n[type=marker,tag=sgp.marker,name=spawn_seeker]

move @s #Chasseurs
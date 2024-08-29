#> sgp.majeurs:hide_and_seek/role/set_seeker
#
# Set the seeker attribute for the role
team join sgp.seeker @s
tag @s add sgp.seeker
tellraw @s [{"text":"Vous devez éliminer tous les Volailles","color":"red"}]
attribute @s generic.attack_damage modifier add sgp.seeker 1000 add_value
function sgp.majeurs:hide_and_seek/stun/stun

#Set the armor
item replace entity @s armor.head with minecraft:leather_helmet[dyed_color={rgb:11546150,show_in_tooltip:true},hide_tooltip={},enchantments={levels:{binding_curse:1},show_in_tooltip:false},enchantment_glint_override=false]
item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color={rgb:11546150,show_in_tooltip:true},hide_tooltip={},enchantments={levels:{binding_curse:1},show_in_tooltip:false},enchantment_glint_override=false]
item replace entity @s armor.legs with minecraft:leather_boots[dyed_color={rgb:11546150,show_in_tooltip:true},hide_tooltip={},enchantments={levels:{binding_curse:1},show_in_tooltip:false},enchantment_glint_override=false]
item replace entity @s armor.feet with minecraft:leather_boots[dyed_color={rgb:11546150,show_in_tooltip:true},hide_tooltip={},enchantments={levels:{binding_curse:1},show_in_tooltip:false},enchantment_glint_override=false]

tp @s @n[type=marker,tag=sgp.marker,name=spawn_seeker]

move @s #Chasseurs
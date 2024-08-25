#> sgp.majeurs:hide_and_seek/role/set_seeker
#
# Set the seeker attribute for the role
team join sgp.seeker @s
tag @s add sgp.seeker
tellraw @s [{"text":"Vous devez éliminer tous les Volailles","color":"red"}]
attribute @s generic.attack_damage modifier add sgp.seeker 1000 add_value
function sgp.majeurs:hide_and_seek/stun/stun

tp @s @n[type=marker,tag=sgp.marker,name=spawn_seeker]

move @s #Chasseurs
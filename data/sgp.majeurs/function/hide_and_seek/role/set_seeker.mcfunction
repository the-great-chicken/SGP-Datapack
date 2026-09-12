#> sgp.majeurs:hide_and_seek/role/set_seeker
#
# Set the seeker attribute for the role

team join sgp.seeker @s
tag @s add sgp.seeker
tag @s add sgp.seeker_waiting
tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Tu dois éliminer toutes les Volailles", color:red}]
attribute @s attack_damage modifier add sgp:hide_and_seek.seeker 1000 add_value
function sgp.misc:stun/apply {duration:infinite}
function sgp.majeurs:hide_and_seek/role/equipment/seeker

tp @s @n[type=marker,tag=sgp.marker,name=spawn_seeker]

function #sgp.hooks:discord/majeurs/hide_and_seek/role/set_seeker_1

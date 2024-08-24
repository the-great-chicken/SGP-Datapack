team join sgp.seeker @s
effect give @s speed infinite 1 true
effect give @s jump_boost infinite 1 true
attribute @s generic.attack_damage modifier add sgp.seeker 1000 add_value
function sgp.majeurs:hide_and_seek/stun/stun

tp @s @n[type=marker,tag=sgp.marker,name=spawn_seeker]

move @s #Chasseurs
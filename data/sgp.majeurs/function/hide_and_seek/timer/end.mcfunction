title @s times 10t 70t 20t
$tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"nbt":"majeurs.hide_and_seek.end.$(role)","storage":"sgp:data","color":"yellow","bold":true}]

execute if entity @s[team=sgp.seeker] run function sgp.majeurs:hide_and_seek/stun/unstun
#> sgp.majeurs:hide_and_seek/timer/end
#
# call when timer end to make a message and unstun the seeker 

title @s times 10t 70t 20t
$tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"nbt":"majeurs.hide_and_seek.end.$(role)","storage":"sgp:data","color":"yellow","bold":true}]

execute if entity @s[tag=sgp.seeker] run function sgp.majeurs:hide_and_seek/role/effect/seeker
execute if entity @s[tag=sgp.hider] run function sgp.majeurs:hide_and_seek/role/effect/seeker
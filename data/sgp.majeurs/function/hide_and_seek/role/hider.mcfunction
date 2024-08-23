team join sgp.hider @s
effect give @s invisibility 60 1 true
attribute @s generic.attack_damage modifier add sgp.hider -0.999 add_value
effect give @s speed 60 5 true
attribute @s generic.movement_speed modifier add sgp.hider 0.2 add_multiplied_total
attribute @s generic.jump_strength modifier add sgp.hider 0.25 add_multiplied_base

tp @s @n[type=marker,tag=sgp.spawn_seekers]
tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text": "Vous êtes une Volaille ! ", "color": "green"}]


function sgp.majeurs:hide_and_seek/timer/hider


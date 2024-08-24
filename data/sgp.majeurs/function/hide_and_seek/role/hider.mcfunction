#> sgp.majeurs:hide_and_seek/role/hider
#
# Définit le rôle de Hider

say hider

team join sgp.hider @s
effect give @s invisibility 60 1 true
attribute @s generic.attack_damage modifier add sgp.hider -0.999 add_value
effect give @s speed 60 5 true

tp @s @n[type=marker,tag=sgp.marker,name=spawn_hider]
tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text": "Vous êtes une Volaille ! ", "color": "green"}]





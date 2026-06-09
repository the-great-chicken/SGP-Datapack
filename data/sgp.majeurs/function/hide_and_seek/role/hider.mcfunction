#> sgp.majeurs:hide_and_seek/role/hider
#
# Définit le rôle de Hider

#say hider

team join sgp.hider @s
effect give @s invisibility 60 1 true
attribute @s attack_damage modifier add sgp:hide_and_seek.hider -0.999 add_value
effect give @s speed 60 4 true
effect give @s resistance 60 10 true


tp @s @n[type=marker,tag=sgp.marker,name=spawn_hider]
tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true},{text: "Tu es une Volaille ! ", color: green}]
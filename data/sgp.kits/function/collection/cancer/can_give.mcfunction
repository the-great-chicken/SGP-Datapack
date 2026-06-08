#> sgp.kits:collection/cancer/can_give

execute if entity @s[team=sgp.Attaquant] run tellraw @s [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"Le kit Cancer n'est pas disponible pour cet événement.", color:dark_red}]
execute if entity @s[team=sgp.Attaquant] run return 0

return 1
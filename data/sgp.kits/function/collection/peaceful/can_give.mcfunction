#> sgp.kits:collection/peaceful/can_give

execute if entity @a[predicate=sgp.majeurs:event_in_progress] run tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Le mode Paisible n'est pas disponible pendant les événements majeurs.", color:dark_red}]
execute if entity @a[predicate=sgp.majeurs:event_in_progress] run return 0

return 1
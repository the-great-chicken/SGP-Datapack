#> sgp.kits:collection/pigeon
# 
# Specific things of the Pigeon kit

effect give @s jump_boost infinite 2

scoreboard players set @s sgp.kit_id 0

execute if entity @s[team=sgp.Attaquant] run clear @s
execute if entity @s[team=sgp.Attaquant] run tellraw @s [{"text":"Le kit Pigeon n'est pas disponible pour cet event.","color":"dark_red"}]
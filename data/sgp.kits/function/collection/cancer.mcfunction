#> sgp.kits:collection/cancer
# 
# Specific things of the Cancer kit

scoreboard players set @s sgp.kit_id 10

execute if entity @s[team=sgp.Attaquant] run clear @s
execute if entity @s[team=sgp.Attaquant] run tellraw @s [{"text":"Le kit Cancer n'est pas disponible pour cet event.", "color":"dark_red"}]
#> sgp.kits:collection/vindicateur/specifics
# 
# Specific things of the Vindicateur kit

tag @s add sgp.vindicateur_a_setup_egapp
tag @s add sgp.vindicateur_voulu

scoreboard players set @s sgp.kit_id 3

execute if entity @s[team=sgp.Attaquant] run clear @s
execute if entity @s[team=sgp.Attaquant] run tellraw @s [{"text":"Le kit Vindicateur n'est pas disponible pour cet event.","color":"dark_red"}]
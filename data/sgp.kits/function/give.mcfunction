#> sgp.kits:give
# `{kit}`
# 
# Gives a kit to the player

clear @s
effect clear @s

$function sgp.kits:collection/$(kit)/items

$tag @s add sgp.$(kit)_voulu
scoreboard players set @s sgp.reset_tags 1

$function sgp.kits:collection/$(kit)/specifics

$scoreboard players set @s sgp.veut_$(kit) 0
scoreboard players set @s sgp.kit_prefix_set 0
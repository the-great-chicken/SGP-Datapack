#> sgp.kits:give
# `{kit}`
# 
# Gives a kit to the player

function sgp.kits:clear

$function sgp.kits:collection/$(kit)/items

$tag @s add sgp.$(kit)_voulu
scoreboard players set @s sgp.reset_tags 1

$function sgp.kits:collection/$(kit)/specifics

$scoreboard players set @s sgp.veut_$(kit) 0
scoreboard players set @s sgp.kit_prefix_set 0
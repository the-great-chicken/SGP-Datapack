#> sgp.kits:give
# `{kit}`
# 
# Gives a kit to the player

clear @s
effect clear @s
attribute @s minecraft:generic.step_height modifier remove kit
attribute @s generic.attack_damage modifier remove kit
god @s off

$function sgp.kits:collection/$(kit)/items

$tag @s add sgp.$(kit)_voulu
scoreboard players set @s sgp.reset_tags 1

$function sgp.kits:collection/$(kit)/specifics

$scoreboard players set @s sgp.veut_$(kit) 0
scoreboard players set @s sgp.kit_prefix_set 0
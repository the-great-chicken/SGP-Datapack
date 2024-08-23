#> sgp.kits:collection/peaceful/specifics
# 
# Specific things of the Peaceful kit

execute unless predicate sgp.majeurs:event_in_progress run god @s on
execute unless predicate sgp.majeurs:event_in_progress run attribute @s minecraft:generic.attack_damage modifier add kit -1 add_multiplied_total

execute unless predicate sgp.majeurs:event_in_progress \
    run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Mode Paisible : ", "color":"green", "bold":true}, {"text":"Tu es invincible et ne peut taper personne. \n\
        Tu es libre d'explorer la map, faire du parkour, ou autre !", "color":"green"}]

execute if predicate sgp.majeurs:event_in_progress \
    run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Le mode Paisible n'est pas disponible pendant les événements majeurs.", "color":"dark_red"}]
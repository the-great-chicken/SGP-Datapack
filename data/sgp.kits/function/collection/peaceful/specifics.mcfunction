#> sgp.kits:collection/peaceful/specifics
# 
# Specific things of the Peaceful kit

execute unless predicate sgp.majeurs:event_in_progress run god @s on
execute unless predicate sgp.majeurs:event_in_progress run effect give @s weakness infinite 99 true


execute unless predicate sgp.majeurs:event_in_progress \
    run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Mode Paisible : ", "color":"green", "bold":true}, {"text":"Tu es invincible et ne peux taper personne. \n\
        Tu es libre d'explorer la map, faire du parkour, ou autre !", "color":"green"}]

execute if predicate sgp.majeurs:event_in_progress \
    run tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Le mode Paisible n'est pas disponible pendant les événements majeurs.", "color":"dark_red"}]
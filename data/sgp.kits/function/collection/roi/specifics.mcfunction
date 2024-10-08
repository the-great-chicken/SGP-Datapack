#> sgp.kits:collection/roi/specifics
# 
# Specific things of the Roi kit

scoreboard players set @s sgp.kit_id 6

execute as @a[tag=sgp.in_game] \
    unless entity @s[tag=!sgp.roi_bleu, tag=!sgp.roi_rouge] \
        run clear @s[scores={sgp.veut_roi=1..}]

execute as @a[tag=sgp.in_game] \
    unless entity @s[tag=!sgp.roi_rouge, tag=!sgp.roi_bleu] \
        run tellraw @s[scores={sgp.veut_roi=1..}] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Le kit Roi n'est pas disponible pour cet event.", "color":"dark_red"}]

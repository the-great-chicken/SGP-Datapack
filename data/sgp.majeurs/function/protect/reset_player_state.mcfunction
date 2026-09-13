#> sgp.majeurs:protect/reset_player_state
#
# Remove Protect-owned player state without touching unrelated effects.

effect clear @s minecraft:health_boost
effect clear @s minecraft:regeneration
tag @s remove sgp.roi_rouge
tag @s remove sgp.roi_bleu

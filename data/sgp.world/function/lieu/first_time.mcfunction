scoreboard players add @s sgp.lieu_count 1
title @s subtitle [{"text":"Nouveau lieu trouvé ! : "},{"score": {"name": "@s","objective": "sgp.lieu_count"}},{"text": " / "},{"score": {"name": "#nbr_lieu","objective": "sgp.lieu_count"}}]
$title @s title {"text":"$(lieu_propre)", "color":"$(couleur)"}
playsound minecraft:ui.cartography_table.take_result ambient @s
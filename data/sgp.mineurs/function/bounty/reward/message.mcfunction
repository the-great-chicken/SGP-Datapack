#> sgp.mineurs:bounty/reward/kill

scoreboard players enable @s sgp.reward
tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"color":"dark_red","text":"[Force]","hoverEvent":{"action":"show_text","contents":[{"text":"donne "},{"color":"dark_red","text":"Force "},{"text":"I pendant 2 minutes"}]},"clickEvent":{"action":"run_command","value":"/trigger sgp.reward set 1"}}\
,{"color":"dark_red","text":"[Force]","hoverEvent":{"action":"show_text","contents":[{"text":"donne "},{"color":"dark_red","text":"Force "},{"text":"I pendant 2 minutes"}]},"clickEvent":{"action":"run_command","value":"/trigger sgp.reward set 1"}}]
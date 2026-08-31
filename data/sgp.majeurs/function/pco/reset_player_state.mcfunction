#> sgp.majeurs:pco/reset_player_state

scoreboard players reset @s sgp.liberer_oies
scoreboard players reset @s sgp.liberer_poules
scoreboard players reset @s sgp.liberer_canards
scoreboard players reset @s sgp.temps_cabane_pco
scoreboard players reset @s sgp.temps_cabane_pco_secondes
scoreboard players reset @s sgp.en_cage
effect clear @s minecraft:strength
effect clear @s minecraft:resistance
effect clear @s minecraft:wither
function sgp.majeurs:pco/cabane/actionbar_clear
tag @s remove sgp.pco.awaiting_cage
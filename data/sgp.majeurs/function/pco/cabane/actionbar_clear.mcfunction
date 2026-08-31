#> sgp.majeurs:pco/cabane/actionbar_clear
# Clear the current player's PCO refuge actionbar segment.

function dah.actbar_mixer:remove/this {id:"sgp:pco_cabane"}
scoreboard players reset @s sgp.ab.pco_cabane

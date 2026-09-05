#> sgp.majeurs:common/eliminate_exit
#
# Treat leaving the arena as a synthetic death, then eliminate the player.

scoreboard players set @s sgp.synthetic_death 1
function sgp.misc:on_death
function sgp.majeurs:common/eliminate
tellraw @s [{storage:"sgp:text",nbt:"prefix",interpret:true},{text:"Tu as quitté l'arène et es éliminé(e) pour cette manche.",color:red}]

#> sgp.mineurs:_stop

tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Désactivation des Événements Mineurs", color:red, bold:true}]

scoreboard players set #events_mineurs_actifs sgp.dummy 0

function sgp.mineurs:lootdrop/clear_existing_ones
function sgp.mineurs:smol/stop
function sgp.mineurs:bounty/stop
function sgp.mineurs:confinement/stop
function sgp.mineurs:frenzy/stop
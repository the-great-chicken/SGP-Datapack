#> sgp.mineurs:confinement/end

tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"CONFINEMENT ! ", color:gray, bold:true},{text:"L'événement est terminé ! Vous pouvez ressortir en toute securité !", color:white}]
function sgp.mineurs:confinement/stop
#> sgp.mineurs:frenzy/end

tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true},{text:"FRENZY! ", color:dark_aqua, bold:true},{text:"Les temps de recharge des compétences sont revenus à la normale.", color:aqua}]
function sgp.mineurs:frenzy/stop

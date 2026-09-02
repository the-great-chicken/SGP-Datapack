#> sgp.mineurs:smol/end

tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"SMOL! ", bold:true, color:dark_blue}, {text:"Le Canarchimage vous a rendu votre taille normale", bold:false, color:blue}]
function sgp.mineurs:smol/stop
#> sgp.majeurs:hide_and_seek/hiders_eliminated

title @a[tag=sgp.in_game] title [{text:"Les Chasseurs gagnent !",color:red}]
tellraw @a[tag=sgp.in_game] [{storage:"sgp:text",nbt:"prefix",interpret:true},{text:"Les ",color:gold},{text:"Chasseurs ",color:dark_green},{text:"ont gagné ! Ils ont éliminé toute la",color:gold},{text:" Volaille",color:yellow}]
function sgp.majeurs:hide_and_seek/_stop

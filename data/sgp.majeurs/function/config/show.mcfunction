#> sgp.majeurs:config/show
#
# Show the BookShelf clock and the current major-event configuration to the caller.

function #bs.time:get

tellraw @s [{text:"Horloge : ",color:gold},{score:{name:"$time.hours",objective:"bs.out"}},{text:" h "},{score:{name:"$time.minutes",objective:"bs.out"}}]
tellraw @s [{text:"Poule Canard Oie : ",color:gold},{score:{name:"#pco_hour",objective:"sgp.dummy"}},{text:" h "},{score:{name:"#pco_minute",objective:"sgp.dummy"}},{text:" — manches : "},{score:{name:"#pco_max_rounds",objective:"sgp.dummy"}}]
tellraw @s [{text:"Cache-cache : ",color:gold},{score:{name:"#hide_and_seek_hour",objective:"sgp.dummy"}},{text:" h "},{score:{name:"#hide_and_seek_minute",objective:"sgp.dummy"}},{text:" — manches : "},{score:{name:"#hide_and_seek_max_rounds",objective:"sgp.dummy"}}]
tellraw @s [{text:"Protéger le Roi : ",color:gold},{score:{name:"#protect_hour",objective:"sgp.dummy"}},{text:" h "},{score:{name:"#protect_minute",objective:"sgp.dummy"}},{text:" — manches : "},{score:{name:"#protect_max_rounds",objective:"sgp.dummy"}}]

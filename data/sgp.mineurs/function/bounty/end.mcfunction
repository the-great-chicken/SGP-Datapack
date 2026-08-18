#> sgp.mineurs:bounty/end

execute as @a[tag=sgp.wanted] run function sgp.mineurs:bounty/reward/message
tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true},{text:"Les survivants du bounty parmi les recherchés sont ",color: yellow},{color:white,selector:"@a[tag=sgp.wanted]"}]
function sgp.mineurs:bounty/stop
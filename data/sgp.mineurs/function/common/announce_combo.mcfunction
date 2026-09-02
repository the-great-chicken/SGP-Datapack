#> sgp.mineurs:common/announce_combo

title @a[tag=sgp.in_game] subtitle [{score:{name:"#random_nbr_events", objective:"sgp.dummy"}},{text:" events mineurs à la fois !!", color:white, bold:true}]
title @a[tag=sgp.in_game] title {text:"COMBO!", color:white, bold:true}

execute if score #random_nbr_events sgp.dummy matches 2 \
    run return run tellraw @a[tag=sgp.in_game] [{text:"COMBO! ", color:white, bold:true}, {text:"2 events mineurs à la fois :", color:white, bold:false}]

tellraw @a[tag=sgp.in_game] [{text:"O", obfuscated:true, bold:true, underlined:true}, {text:" COMBO! ", color:white, obfuscated:false, italic:true}, {text:"O", obfuscated:true}, {text:" 3 events mineurs à la fois :", color:white, obfuscated:false, underlined:false, bold:false}]
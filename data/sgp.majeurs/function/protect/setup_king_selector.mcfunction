#> sgp.majeurs:protect/setup_king_selector
# `{side, team, name, color}`
#
# Rewrite the marker's sign and create its correctly aligned interaction entity.

$kill @e[tag=sgp.protect.king_selector.$(side),type=interaction]
$data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{text:"DEVENIR",bold:true,color:$(color)}]','["",{text:"LE ROI",bold:true,color:$(color)}]','[""]']}}
$summon minecraft:interaction ^ ^1.25 ^0.1 {Tags:["sgp.interaction","sgp.protect.king_selector","sgp.protect.king_selector.$(side)"],response:true,width:1.1f,height:0.54f,data:{function:"sgp.majeurs:protect/select_king",args:{side:"$(side)",team:"$(team)",name:"$(name)",color:"$(color)"}}}

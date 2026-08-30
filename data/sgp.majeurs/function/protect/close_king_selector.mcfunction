#> sgp.majeurs:protect/close_king_selector
# `{side}`
#
# Remove one king selector and mark its sign as inactive.

$kill @e[tag=sgp.protect.king_selector.$(side),type=interaction]
$execute as @e[tag=sgp.marker,name="devenir_roi_$(side)",limit=1,type=marker] at @s run data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{text:"SÉLECTION",bold:true,color:gray}]','["",{text:"FERMÉE",bold:true,color:gray}]','[""]']}}

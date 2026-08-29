#> sgp.majeurs:pco/cabane/inside_actionbar
# 
# Show the actionbar when inside the cabane

scoreboard players set @s sgp.ab.pco_cabane 5
data modify storage dah:actbar new set value {id:"sgp:pco_cabane",order:0,text:["",{text:"Temps autorisé dans le refuge : "},{score:{name:"@s",objective:"sgp.temps_cabane_pco_secondes"},bold:true,color:red}]}
function dah.actbar_mixer:new/update_id
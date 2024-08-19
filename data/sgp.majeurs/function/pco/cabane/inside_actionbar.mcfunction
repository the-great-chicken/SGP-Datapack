#> sgp.majeurs:pco/cabane/inside_actionbar
# 
# Show the actionbar when inside the cabane, using the smithed actionbar library for compatibility

data modify storage smithed.actionbar:input message set value {json:'["",{"text":"Temps autorisé dans le refuge : "},{"score":{"name":"@s","objective":"sgp.temps_cabane_pco_secondes"},"bold":true,"color":"red"}]',priority:'override'}
execute as @s run function #smithed.actionbar:message
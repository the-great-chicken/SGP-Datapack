#> sgp.kits:kills_give/alchimiste_1
# 
# Gives the reward for each kill as an Alchimiste: potions that get stacked
# to existing ones in the player's inventory

function sgp.kits:stacking/add_count_to_stack {item_id:splash_potion, count:2, tag:"Potion:\"minecraft:healing\",HideFlags:63,display:{Name:'{\"text\":\"Potion de Soin\",\"color\":\"light_purple\",\"italic\":false,\"bold\":true}',Lore:['[{\"text\":\"Régénère jusqu\\'à 2\",\"color\":\"gray\",\"italic\":false},{\"text\":\"❤\",\"color\":\"red\"},{\"text\":\" instantanément\",\"color\":\"gray\"}]']}"}
function sgp.kits:stacking/add_count_to_stack {item_id:splash_potion, count:3, tag:"Potion:\"minecraft:harming\",HideFlags:63,display:{Name:'{\"text\":\"Potion de Dégats\",\"color\":\"light_purple\",\"italic\":false,\"bold\":true}',Lore:['{\"text\":\"Inflige jusqu\\'à 4 dégâts\",\"color\":\"gray\",\"italic\":false}']}"}
data modify storage smithed.actionbar:input message set value {json:'[{"text":"+ 2 ❤ Potions de Soin ", "color":"red", "bold":true},{"text":"et 3 ⚔ Potions de Dégats !", "color":"dark_red"}]',priority:'notification'}
execute as @s run function #smithed.actionbar:message
scoreboard players set @s sgp.kills_give_1 0
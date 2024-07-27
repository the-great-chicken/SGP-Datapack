#> sgp.kits:collection/alchimiste/kills_give_1
# 
# Gives the reward for each kill as an Alchimiste: potions that get stacked
# to existing ones in the player's inventory

function sgp.kits:stacking/add_count_to_stack { \
    item_id:splash_potion, \
    count:2, \
    tag:" \
        \"minecraft:custom_name\":'{\"bold\":true,\"color\":\"light_purple\",\"italic\":false,\"text\":\"Potion de Soin\"}', \
        \"minecraft:lore\": [ \
            '{\"color\":\"gray\",\"extra\":[{\"color\":\"red\",\"text\":\"❤\"},\" instantanément\"],\"italic\":false,\"text\":\"Régénère jusqu\\'à 2\"}' \
            ], \
        \"minecraft:potion_contents\":{potion:\"minecraft:healing\"}, \
        \"minecraft:hide_additional_tooltip\":{} \
        " \
    }

function sgp.kits:stacking/add_count_to_stack { \
    item_id:splash_potion, \
    count:3, \
    tag:" \
        \"minecraft:custom_name\":'{\"bold\":true,\"color\":\"light_purple\",\"italic\":false,\"text\":\"Potion de Dégats\"}', \
        \"minecraft:lore\": [ \
            '{\"color\":\"gray\",\"italic\":false,\"text\":\"Inflige jusqu\\'à 4 dégâts\"}' \
        ], \
        \"minecraft:potion_contents\":{potion:\"minecraft:harming\"}, \
        \"minecraft:hide_additional_tooltip\":{} \
        " \
    }


data modify storage smithed.actionbar:input message set value { \
    json:'[ \
        {"text":"+ 2 ❤ Potions de Soin ", "color":"red", "bold":true}, \
        {"text":"et 3 ⚔ Potions de Dégats !", "color":"dark_red"} \
        ]', \
    priority:'notification' \
    }

execute as @s run function #smithed.actionbar:message
scoreboard players set @s sgp.kills_give_1 0
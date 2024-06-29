#> sgp.kits:collection/alchimiste
# 
# Gives the Alchimiste kit to the player

clear @s
effect clear @s
item replace entity @s hotbar.0 with stone_sword[\
    unbreakable={show_in_tooltip:0b}, \
    enchantments={levels: {sharpness:1}, show_in_tooltip:false}, \
    custom_name='{"text":"Épée en Pierre", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[\
        '{"text":"---------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"⚔ Tranchant I", "color":"dark_red", "italic":false}', \
        '{"text":"6 dégats", "color":"blue", "italic":false}'], \
    attribute_modifiers={modifiers: [{type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:5.0, operation:"add_value"}], show_in_tooltip:false}]

item replace entity @s weapon.offhand with baked_potato[\
    custom_name='{"text":"Pommes de Terre cuites au Four", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[\
        '[\
            {"text":"Régénère jusqu\'à 3", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"}]']]

item replace entity @s hotbar.3 with splash_potion[\
    custom_name='{"text":"Potion de Cécité", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[\
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"👁 Cécité (0:05)", "color":"#8B8589", "italic":false}'], \
    potion_contents={potion:"water", custom_effects:[{id:"blindness", amplifier:0, duration:100}]}]

item replace entity @s hotbar.4 with milk_bucket[\
    custom_name='{"text":"Antibiotique", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[\
        '{"text":"Enlève tous les effets", "color":"gray", "italic":false}']]

item replace entity @s armor.head with chainmail_helmet[\
    unbreakable={show_in_tooltip:false}, \
    enchantments={levels:{protection:1}, show_in_tooltip:false}, \
    custom_name='{"text":"Casque de Mailles", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[\
        '{"text":"------------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}'], \
    trim={pattern:"tide", material:"amethyst", show_in_tooltip:false}, \
    attribute_modifiers={modifiers:[], show_in_tooltip:false}]

item replace entity @s armor.chest with chainmail_chestplate[\
    unbreakable={show_in_tooltip:false}, \
    enchantments={levels:{protection:1, projectile_protection:2}, show_in_tooltip:false}, \
    custom_name='{"text":"Cotte de Mailles", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[\
        '{"text":"----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}', \
        '{"text":"➹ Protection II", "color":"dark_blue", "italic":false}'], \
    trim={pattern:"sentry", material:"amethyst", show_in_tooltip:false}, \
    attribute_modifiers={modifiers:[], show_in_tooltip:false}]

item replace entity @s armor.legs with chainmail_leggings[\
    unbreakable={show_in_tooltip:false}, \
    enchantments={levels:{protection:1}, show_in_tooltip:false}, \
    custom_name='{"text":"Jambières de Mailles", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[\
        '{"text":"--------------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}'], \
    trim={pattern:"sentry", material:"amethyst", show_in_tooltip:false}, \
    attribute_modifiers={modifiers:[], show_in_tooltip:false}]

item replace entity @s armor.feet with minecraft:chainmail_boots[\
    unbreakable={show_in_tooltip:false}, \
    enchantments={levels:{protection:1}, show_in_tooltip:false}, \
    custom_name='{"text":"Bottes de Mailles", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[\
        '{"text":"-----------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}'], \
    trim={pattern:'sentry', material:'amethyst', show_in_tooltip:false}, \
    attribute_modifiers={modifiers:[], show_in_tooltip:false}]

tag @s add alchimiste_voulu
scoreboard players set @s sgp.reset_tags 1
scoreboard players set @s sgp.kit_id 8
function sgp.kits:stacking/set_stack {item_id:splash_potion, count:8, slot:hotbar.1, tag:"Potion:\"minecraft:healing\",HideFlags:63,display:{Name:'{\"text\":\"Potion de Soin\",\"color\":\"light_purple\",\"italic\":false,\"bold\":true}',Lore:['[{\"text\":\"Régénère jusqu\\'à 2\",\"color\":\"gray\",\"italic\":false},{\"text\":\"❤\",\"color\":\"red\"},{\"text\":\" instantanément\",\"color\":\"gray\"}]']}"}
function sgp.kits:stacking/set_stack {item_id:splash_potion, count:10, slot:hotbar.2, tag:"Potion:\"minecraft:harming\",HideFlags:63,display:{Name:'{\"text\":\"Potion de Dégats\",\"color\":\"light_purple\",\"italic\":false,\"bold\":true}',Lore:['{\"text\":\"Inflige jusqu\\'à 4 dégâts\",\"color\":\"gray\",\"italic\":false}']}"}
scoreboard players set @s sgp.veut_alchimiste 0
scoreboard players set @s sgp.kit_prefix_set 0
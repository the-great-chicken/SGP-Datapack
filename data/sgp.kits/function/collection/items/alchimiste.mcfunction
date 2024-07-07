#> sgp.kits:collection/items/alchimiste
# 
# Gives the items of the Alchimiste kit to the player

# ---------- WEAPONS ----------
item replace entity @s hotbar.0 with stone_sword[ \
    unbreakable={show_in_tooltip:false}, \
    enchantments={ \
        levels: {sharpness:1}, \
        show_in_tooltip:false \
        }, \
    custom_name='{"text":"Épée en Pierre", "color":"light_purple", "italic":false, "bold":true}', \
    lore=[ \
        '{"text":"---------------", "color":"#C0C0C0", "italic":false}', \
        '{"text":"⚔ Tranchant I", "color":"dark_red", "italic":false}', \
        '{"text":"6 dégats", "color":"blue", "italic":false}' \
        ], \
    attribute_modifiers={ \
        modifiers: [ \
            {type:"generic.attack_damage", slot:"mainhand", id:"sgp.damage", amount:5.0, operation:"add_value"} \
            ], \
        show_in_tooltip:false \
        } \
    ]

# ---------- ARMOR PIECES ----------
item replace entity @s armor.head with chainmail_helmet{Trim:{pattern:tide, material:amethyst}, Unbreakable:1, Enchantments:[{id:"protection", lvl:1}], HideFlags:255, display:{Name:'{"text":"Casque de Mailles", "color":"light_purple", "italic":false, "bold":true}', Lore:['{"text":"------------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}']}}
item replace entity @s armor.chest with chainmail_chestplate{Trim:{pattern:sentry, material:amethyst}, Unbreakable:1, Enchantments:[{id:"protection", lvl:1}, {id:"projectile_protection", lvl:2}], HideFlags:255, display:{Name:'{"text":"Cotte de Mailles", "color":"light_purple", "italic":false, "bold":true}', Lore:['{"text":"----------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}', '{"text":"➹ Protection II", "color":"dark_blue", "italic":false}']}}
item replace entity @s armor.legs with chainmail_leggings{Trim:{pattern:sentry, material:amethyst}, Unbreakable:1, Enchantments:[{id:"protection", lvl:1}], HideFlags:255, display:{Name:'{"text":"Jambières de Mailles", "color":"light_purple", "italic":false, "bold":true}', Lore:['{"text":"--------------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}']}}
item replace entity @s armor.feet with chainmail_boots{Trim:{pattern:sentry, material:amethyst}, Unbreakable:1, Enchantments:[{id:"protection", lvl:1}], HideFlags:255, display:{Name:'{"text":"Bottes de Mailles", "color":"light_purple", "italic":false, "bold":true}', Lore:['{"text":"-----------------", "color":"#C0C0C0", "italic":false}', '{"text":"🛡 Protection I", "color":"dark_aqua", "italic":false}']}}

# ---------- POTIONS / ARROWS ----------
function sgp.kits:stacking/set_stack {item_id:splash_potion, count:8, slot:hotbar.1, tag:"Potion:\"minecraft:healing\",HideFlags:63,display:{Name:'{\"text\":\"Potion de Soin\",\"color\":\"light_purple\",\"italic\":false,\"bold\":true}',Lore:['[{\"text\":\"Régénère jusqu\\'à 2\",\"color\":\"gray\",\"italic\":false},{\"text\":\"❤\",\"color\":\"red\"},{\"text\":\" instantanément\",\"color\":\"gray\"}]']}"}
function sgp.kits:stacking/set_stack {item_id:splash_potion, count:10, slot:hotbar.2, tag:"Potion:\"minecraft:harming\",HideFlags:63,display:{Name:'{\"text\":\"Potion de Dégats\",\"color\":\"light_purple\",\"italic\":false,\"bold\":true}',Lore:['{\"text\":\"Inflige jusqu\\'à 4 dégâts\",\"color\":\"gray\",\"italic\":false}']}"}
item replace entity @s hotbar.3 with splash_potion{Potion:"water", custom_potion_effects:[{id:"blindness", amplifier:0, duration:100}], HideFlags:63, display:{Name:'{"text":"Potion de Cécité", "color":"light_purple", "italic":false, "bold":true}', Lore:['{"text":"----------------", "color":"#C0C0C0", "italic":false}', '{"text":"👁 Cécité (0:05)", "color":"#8B8589", "italic":false}']}}

# ---------- FOOD ----------
item replace entity @s weapon.offhand with baked_potato{display:{Name:'{"text":"Pommes de Terre cuites au Four", "color":"light_purple", "italic":false, "bold":true}', Lore:['[{"text":"Régénère jusqu\'à 3", "color":"gray", "italic":false}, {"text":"❤", "color":"red", "italic":false}]']}} 64

# ---------- MISC ITEMS ----------
item replace entity @s hotbar.4 with milk_bucket{display:{Name:'{"text":"Antibiotique", "color":"light_purple", "italic":false, "bold":true}', Lore:['[{"text":"Enlève tous les effets", "color":"gray", "italic":false}]']}}

#> sgp.ci:protection/scenarios/alchemical/equipment_slot

function sgp.ci:protection/prepare
item replace entity @s armor.head with leather_helmet[attribute_modifiers=[],enchantments={"sgp.kits:alchemical_protection":1}]
item replace entity @s armor.chest with leather_chestplate[attribute_modifiers=[],enchantments={"sgp.kits:alchemical_protection":1}]
item replace entity ProtectPeer armor.chest with leather_chestplate[attribute_modifiers=[],enchantments={"sgp.kits:alchemical_protection":1}]
damage @s 10 minecraft:magic
damage ProtectPeer 10 minecraft:magic
execute as @s run function sgp.ci:protection/health {range:"12399..12401"}
execute as ProtectPeer run function sgp.ci:protection/health {range:"9999..10001"}

#> sgp.ci:protection/scenarios/alchemical/kit_requirement

function sgp.ci:protection/prepare
item replace entity @s armor.head with leather_helmet[attribute_modifiers=[],enchantments={"sgp.kits:alchemical_protection":1}]
item replace entity ProtectPeer armor.head with leather_helmet[attribute_modifiers=[],enchantments={"sgp.kits:alchemical_protection":1}]
scoreboard players set ProtectPeer sgp.kit_id 7
damage @s 10 minecraft:magic
damage ProtectPeer 10 minecraft:magic
execute as @s run function sgp.ci:protection/health {range:"12399..12401"}
execute as ProtectPeer run function sgp.ci:protection/health {range:"9999..10001"}

#> sgp.ci:protection/scenarios/alchemical/other_damage

function sgp.ci:protection/prepare
item replace entity @s armor.head with leather_helmet[attribute_modifiers=[],enchantments={"sgp.kits:alchemical_protection":1}]
damage @s 10 minecraft:generic
damage ProtectPeer 10 minecraft:generic
execute as @s run function sgp.ci:protection/health {range:"9999..10001"}
execute as ProtectPeer run function sgp.ci:protection/health {range:"9999..10001"}

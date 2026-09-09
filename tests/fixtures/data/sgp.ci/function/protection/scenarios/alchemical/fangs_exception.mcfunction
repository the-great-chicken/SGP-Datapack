#> sgp.ci:protection/scenarios/alchemical/fangs_exception

function sgp.ci:protection/prepare
item replace entity @s armor.head with leather_helmet[attribute_modifiers=[],enchantments={"sgp.kits:alchemical_protection":1}]
summon evoker_fangs ~8.5 ~1 ~8.5 {Tags:["sgp.ci.protection_fangs"],Warmup:100}
damage @s 10 minecraft:magic by @e[tag=sgp.ci.protection_fangs,limit=1,type=evoker_fangs]
damage ProtectPeer 10 minecraft:magic by @e[tag=sgp.ci.protection_fangs,limit=1,type=evoker_fangs]
execute as @s run function sgp.ci:protection/health {range:"9999..10001"}
execute as ProtectPeer run function sgp.ci:protection/health {range:"9999..10001"}

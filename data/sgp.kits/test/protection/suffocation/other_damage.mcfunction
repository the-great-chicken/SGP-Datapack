#> sgp.kits:protection/suffocation/other_damage
# @dummy
# @environment sgp.ci:protection/suffocation/other_damage
#
# Suffocation immunity leaves ordinary damage unchanged.

function sgp.ci:protection/roster
await delay 61t
function sgp.ci:protection/prepare
item replace entity @s armor.head with leather_helmet[attribute_modifiers=[],enchantments={"sgp.kits:suffocation_immunity":1}]
damage @s 10 minecraft:generic
damage ProtectPeer 10 minecraft:generic
execute as @s run function sgp.ci:protection/health {range:"9999..10001"}
execute as ProtectPeer run function sgp.ci:protection/health {range:"9999..10001"}

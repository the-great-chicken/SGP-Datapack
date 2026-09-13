#> sgp.kits:protection/suffocation/unequip
# @dummy
# @environment sgp.ci:protection/suffocation/unequip
#
# Removing the enchanted item restores vulnerability to suffocation.

function sgp.ci:protection/roster
await delay 61t
function sgp.ci:protection/prepare
item replace entity @s armor.head with leather_helmet[attribute_modifiers=[],enchantments={"sgp.kits:suffocation_immunity":1}]
damage @s 10 minecraft:in_wall
execute as @s run function sgp.ci:protection/health {range:"20000"}
item replace entity @s armor.head with air
damage @s 10 minecraft:in_wall
damage ProtectPeer 10 minecraft:in_wall
execute as @s run function sgp.ci:protection/health {range:"9999..10001"}
execute as ProtectPeer run function sgp.ci:protection/health {range:"9999..10001"}

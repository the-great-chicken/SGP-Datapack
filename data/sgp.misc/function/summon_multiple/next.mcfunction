#> sgp.misc:summon_multiple/next
# `{entity: entity_type, nbt: nbt_compound_tag, execute: command}`
#
# Consume the remaining summons for the current call.

execute if score #summon_nbr sgp.dummy matches ..0 run return 0
scoreboard players remove #summon_nbr sgp.dummy 1
$execute summon $(entity) run function sgp.misc:summon_multiple_exec {nbt:$(nbt), execute:'$(execute)'}
$function sgp.misc:summon_multiple/next {entity:$(entity), nbt:$(nbt), execute:'$(execute)'}

#> sgp.misc:summon_multiple
#
# `{nbr: int, entity: entity_type, nbt: nbt_compound_tag, execute: command}`
# Summons $nbr $entity with specified $nbt, at execution position
# Runs the $execute command as each newly created entity
# If you don't want to execute anything, use `execute:'return 0'`
# You should escape any single quotes in the command to execute.

execute if score #summon_nbr sgp.dummy matches 0 run return run scoreboard players remove #summon_nbr sgp.dummy 1
$execute if score #summon_nbr sgp.dummy matches ..-1 run scoreboard players set #summon_nbr sgp.dummy $(nbr)
scoreboard players remove #summon_nbr sgp.dummy 1

$execute summon $(entity) run function sgp.misc:summon_multiple_exec {nbt:$(nbt), execute:'$(execute)'}

$function sgp.misc:summon_multiple {nbr:$(nbr), entity:$(entity), nbt:$(nbt), execute:'$(execute)'}
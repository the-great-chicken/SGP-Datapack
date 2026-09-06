#> sgp.misc:summon_multiple
#
# `{nbr: int, entity: entity_type, nbt: nbt_compound_tag, execute: command}`
# Summons $nbr $entity with specified $nbt, at execution position
# Runs the $execute command as each newly created entity
# If you don't want to execute anything, use `execute:'return 0'`
# You should escape any single quotes in the command to execute.

$scoreboard players set #summon_nbr sgp.dummy $(nbr)
$function sgp.misc:summon_multiple/next {entity:$(entity), nbt:$(nbt), execute:'$(execute)'}

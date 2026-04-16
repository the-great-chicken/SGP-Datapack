#> sgp.misc:summon_multiple_exec
#
# `{nbt: nbt_compound_tag, execute: command}`

$data merge entity @s $(nbt)

$$(execute)
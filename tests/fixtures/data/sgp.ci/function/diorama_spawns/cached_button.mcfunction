#> sgp.ci:diorama_spawns/cached_button
# `{uuid: entity UUID}`
#
# Executed from one cached entry, verify its UUID resolves to a generated spawn interaction.

$assert entity $(uuid)
$execute as $(uuid) run assert entity @s[tag=sgp.spawn_tper,type=interaction]

#> sgp.majeurs:reconnect_cleanup/spectator
# @dummy
# @environment sgp.ci:major_reconnect
#
# A spectator who missed stop-time cleanup is released on reconnect without
# losing the normal loadout they brought into spectator mode.

tag @s add sgp.major_spectator
gamemode spectator @s
give @s minecraft:stone 1

function sgp.majeurs:repair_reconnected_players

assert entity @s[gamemode=survival,tag=!sgp.major_participant,tag=!sgp.major_spectator]
assert entity @s[nbt={Inventory:[{id:"minecraft:stone"}]}]

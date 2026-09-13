#> sgp.kits:ability_entrypoints/assassinate
# @dummy
# @environment sgp.ci:ability_entrypoints/assassinate
#
# Enderman routing must enter the real assassin state and initialize both configured timers.

function sgp.ci:ability_entrypoints/seed_stats {id:920001,kit:9,ability:"assassinate"}
tag @s add sgp.enderman
scoreboard players set @s sgp.damage_resisted 73

execute at @s run function sgp.kits:abilities/route_ability

function sgp.ci:ability_entrypoints/expect_timers {ability:"assassinate"}
assert entity @s[tag=sgp.assassin,nbt={active_effects:[{id:"minecraft:resistance",amplifier:4b}]}]
assert score @s sgp.damage_resisted matches 0

# Retire the transient state so this test never leaks a modifier/effect to teardown.
function sgp.kits:abilities/assassinate/end
assert not entity @s[tag=sgp.assassin]
assert not entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]

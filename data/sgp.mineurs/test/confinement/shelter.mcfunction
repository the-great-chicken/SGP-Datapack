#> sgp.mineurs:confinement/shelter
# @dummy
# @environment sgp.ci:confinement/shelter
#
# Shelter blocks prevent damage; removing shelter exposes participants while outsiders remain safe.

data modify storage sgp:data tests.confinement_shelter set value {}
gamemode survival @s
tp @s ~0.5 ~1 ~0.5
dummy ConfineOutside spawn
gamemode survival ConfineOutside
tp ConfineOutside ~4.5 ~1 ~0.5
fill ~-1 ~1 ~-1 ~5 ~3 ~1 air
setblock ~ ~ ~ stone
setblock ~4 ~ ~ stone
# Wait for the dummy client-loading protection to expire before checking damage.
await delay 61t
tag @s add sgp.in_game
setblock ~ ~2 ~ minecraft:spruce_slab
function sgp.mineurs:confinement/damage
execute store result storage sgp:data tests.confinement_shelter.protected int 1 run data get entity @s Health
setblock ~ ~2 ~ minecraft:air
function sgp.mineurs:confinement/damage
execute store result storage sgp:data tests.confinement_shelter.exposed int 1 run data get entity @s Health
execute store result storage sgp:data tests.confinement_shelter.outside int 1 run data get entity ConfineOutside Health
dummy ConfineOutside leave

assert data storage sgp:data tests.confinement_shelter{protected:20,exposed:16,outside:20}
assert not entity @s[tag=sgp.unprotected]
data remove storage sgp:data tests.confinement_shelter

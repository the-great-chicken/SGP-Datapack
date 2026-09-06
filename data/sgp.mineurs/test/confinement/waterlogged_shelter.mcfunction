#> sgp.mineurs:confinement/waterlogged_shelter
# @dummy
# @environment sgp.ci:confinement/waterlogged_shelter
#
# Blocks from the waterlogged-only shelter list protect only while waterlogged.

data modify storage sgp:data tests.confinement_water set value {}
gamemode survival @s
tp @s ~0.5 ~1 ~0.5
fill ~-1 ~1 ~-1 ~1 ~3 ~1 air
setblock ~ ~ ~ stone
# Wait for the dummy client-loading protection to expire before checking damage.
await delay 61t
tag @s add sgp.in_game
setblock ~ ~2 ~ minecraft:waxed_cut_copper_slab[waterlogged=true]
function sgp.mineurs:confinement/damage
execute store result storage sgp:data tests.confinement_water.wet int 1 run data get entity @s Health
setblock ~ ~2 ~ minecraft:waxed_cut_copper_slab[waterlogged=false]
function sgp.mineurs:confinement/damage
execute store result storage sgp:data tests.confinement_water.dry int 1 run data get entity @s Health
setblock ~ ~2 ~ minecraft:air

assert data storage sgp:data tests.confinement_water{wet:20,dry:16}
data remove storage sgp:data tests.confinement_water

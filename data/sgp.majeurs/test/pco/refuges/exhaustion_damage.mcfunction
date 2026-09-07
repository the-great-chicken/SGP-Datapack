#> sgp.majeurs:pco/refuges/exhaustion_damage
# @dummy
# @environment sgp.ci:pco/refuge_exhaustion
#
# Wither actually damages an exhausted player while the old two-second Resistance effect would otherwise still be active.

function sgp.ci:pco/refuge_fixture
gamemode survival @s
# Wait for dummy client-loading protection before checking damage.
await delay 61t
scoreboard players set @s sgp.temps_cabane_pco 10
function sgp.majeurs:pco/cabane/run_check_inside
assert entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]
assert entity @s[nbt={Health:20.0f}]
function sgp.majeurs:pco/cabane/run_check_inside
# Observe the damage before natural regeneration can heal it.
await not entity @s[nbt={Health:20.0f}]
execute store result score @s sgp.dummy run data get entity @s Health
assert score @s sgp.dummy matches 1..19
assert score @s sgp.temps_cabane_pco matches 0

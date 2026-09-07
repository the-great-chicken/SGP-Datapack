#> sgp.majeurs:pco/refuges/recovery_after_exhaustion
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Overstaying creates no debt: the first check outside recharges immediately, and earned time protects the player on re-entry.

function sgp.ci:pco/refuge_fixture
scoreboard players set @s sgp.temps_cabane_pco 0
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
tp @s ~12.5 ~1 ~3.5
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 1
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 6

tp @s ~0.5 ~1 ~0.5
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 1
assert entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 0
assert not entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]
assert entity @s[nbt={active_effects:[{id:"minecraft:wither"}]}]

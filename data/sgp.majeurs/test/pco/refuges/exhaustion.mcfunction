#> sgp.majeurs:pco/refuges/exhaustion
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Exhaustion ends protection immediately, keeps the allowance/HUD at zero, and does not affect another player's protection.

function sgp.ci:pco/refuge_fixture
dummy PcoProtected spawn
tag PcoProtected add sgp.ci.pco_actor
team join sgp.Oie PcoProtected
tp PcoProtected ~0.5 ~1 ~0.5
scoreboard players set PcoProtected sgp.temps_cabane_pco 100
execute as PcoProtected run function sgp.majeurs:pco/cabane/run_check_inside
scoreboard players set @s sgp.temps_cabane_pco 10
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 5
assert entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]

function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 0
assert score @s sgp.temps_cabane_pco_secondes matches 0
assert not entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]
assert entity @s[nbt={active_effects:[{id:"minecraft:wither",amplifier:1b}]}]
assert score PcoProtected sgp.temps_cabane_pco matches 95
assert entity @a[name=PcoProtected,nbt={active_effects:[{id:"minecraft:resistance"}]}]

function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 0
assert score @s sgp.temps_cabane_pco_secondes matches 0
# Continued refuge checks keep the intended Wither II penalty active without creating allowance debt.
assert entity @s[nbt={active_effects:[{id:"minecraft:wither",amplifier:1b}]}]

# Less than one check's allowance and a first visit without a score both exhaust at zero.
scoreboard players set @s sgp.temps_cabane_pco 2
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 0
scoreboard players reset @s sgp.temps_cabane_pco
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 0
assert score @s sgp.temps_cabane_pco_secondes matches 0
assert not entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]

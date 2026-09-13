#> sgp.majeurs:pco/refuges/allowance_and_hud
# @dummy
# @environment sgp.ci:pco/synchronous
#
# The allowance recharges outside, drains inside, and publishes the updated whole-second value on the same check.

function sgp.ci:pco/refuge_fixture
tp @s ~12.5 ~1 ~3.5
scoreboard players reset @s sgp.temps_cabane_pco
scoreboard players reset @s sgp.temps_cabane_pco_secondes
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 1
assert score @s sgp.temps_cabane_pco_secondes matches 0

scoreboard players set @s sgp.temps_cabane_pco 205
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 206
assert score @s sgp.temps_cabane_pco_secondes matches 2
tp @s ~0.5 ~1 ~0.5
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 201
assert score @s sgp.temps_cabane_pco_secondes matches 2
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 196
assert score @s sgp.temps_cabane_pco_secondes matches 1
assert data storage dah:actbar new{id:"sgp:pco_cabane",text:[{score:{name:"@s",objective:"sgp.temps_cabane_pco_secondes"}}]}

tp @s ~12.5 ~1 ~3.5
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 201
assert score @s sgp.temps_cabane_pco_secondes matches 2

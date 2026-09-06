#> sgp.majeurs:pco/refuges/team_routing
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Each team spends its allowance in its own designated refuge; another team's green floor cannot grant refuge protection.

function sgp.ci:pco/refuge_fixture
scoreboard players set @s sgp.temps_cabane_pco 1000
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 995
assert entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]

effect clear @s resistance
tp @s ~32.5 ~1 ~0.5
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 996
assert not entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]
team join sgp.Poule @s
scoreboard players set @s sgp.temps_cabane_pco 1000
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 995
assert entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]

effect clear @s resistance
team join sgp.Canard @s
tp @s ~0.5 ~1 ~32.5
scoreboard players set @s sgp.temps_cabane_pco 1000
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 995
assert entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]

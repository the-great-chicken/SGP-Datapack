#> sgp.majeurs:pco/refuges/player_isolation_and_reset
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Players spend/recharge independently, and resetting one player's round clears refuge state while preserving unrelated effects and the teammate's state.

function sgp.ci:pco/refuge_fixture
scoreboard players set @s sgp.temps_cabane_pco 205
effect give @s night_vision infinite 0 true
dummy PcoRefugeOther spawn
tag PcoRefugeOther add sgp.ci.pco_actor
team join sgp.Oie PcoRefugeOther
tp PcoRefugeOther ~12.5 ~1 ~3.5
scoreboard players set PcoRefugeOther sgp.temps_cabane_pco 99
function sgp.majeurs:pco/cabane/run_check_inside
execute as PcoRefugeOther run function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 200
assert score @s sgp.temps_cabane_pco_secondes matches 2
assert score PcoRefugeOther sgp.temps_cabane_pco matches 100
assert score PcoRefugeOther sgp.temps_cabane_pco_secondes matches 1
assert not entity @a[name=PcoRefugeOther,nbt={active_effects:[{id:"minecraft:resistance"}]}]

tp PcoRefugeOther ~0.5 ~1 ~0.5
execute as PcoRefugeOther run function sgp.majeurs:pco/cabane/run_check_inside
function sgp.majeurs:pco/reset_player_state
assert not score @s sgp.temps_cabane_pco matches -2147483648..2147483647
assert not score @s sgp.temps_cabane_pco_secondes matches -2147483648..2147483647
assert not score @s sgp.ab.pco_cabane matches 1..
assert not entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]
assert entity @s[nbt={active_effects:[{id:"minecraft:night_vision"}]}]
assert score PcoRefugeOther sgp.temps_cabane_pco matches 95
assert score PcoRefugeOther sgp.temps_cabane_pco_secondes matches 0
assert entity @a[name=PcoRefugeOther,nbt={active_effects:[{id:"minecraft:resistance"}]}]

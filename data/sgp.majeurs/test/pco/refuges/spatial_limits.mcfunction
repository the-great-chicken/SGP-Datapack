#> sgp.majeurs:pco/refuges/spatial_limits
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Refuge protection requires green concrete within the active cage's inclusive radius; inactive arena markers do not count.

function sgp.ci:pco/refuge_fixture
setblock ~15 ~ ~ green_concrete
scoreboard players set @s sgp.temps_cabane_pco 1000
tp @s ~15 ~1 ~
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 995
tp @s ~15.01 ~1 ~
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 996
tp @s ~8.5 ~1 ~0.5
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 997

tp @e[tag=sgp.ci.pco,tag=sgp.pco.active,name=pco_poule_cage_arena,distance=..48,limit=1,type=marker] ~32 ~1 ~32
summon marker ~ ~1 ~ {CustomName:"pco_poule_cage_arena",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_beta"}}
tp @s ~0.5 ~1 ~0.5
effect clear @s resistance
function sgp.majeurs:pco/cabane/run_check_inside
assert score @s sgp.temps_cabane_pco matches 998
assert not entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]

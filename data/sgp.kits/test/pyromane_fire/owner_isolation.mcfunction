#> sgp.kits:pyromane_fire/owner_isolation
# @dummy
# @environment sgp.ci:pyromane_fire
#
# Two projectiles preserve separate fire owners and durations.

function sgp.ci:pyromane_fire/fixture
function sgp.ci:pyromane_fire/create {owner:91001,x:"~0.5"}
function sgp.ci:pyromane_fire/create {owner:91002,x:"~10.5"}
execute positioned ~0.5 ~1 ~0.5 run assert entity @e[tag=sgp.ci.fire,scores={sgp.damage_owner=91001,sgp.timer=100},distance=..0.01,type=marker]
execute positioned ~10.5 ~1 ~0.5 run assert entity @e[tag=sgp.ci.fire,scores={sgp.damage_owner=91002,sgp.timer=100},distance=..0.01,type=marker]
execute store result score #ci.fire.count sgp.dummy if entity @e[tag=sgp.ci.fire,distance=..24,type=marker]
assert score #ci.fire.count sgp.dummy matches 2

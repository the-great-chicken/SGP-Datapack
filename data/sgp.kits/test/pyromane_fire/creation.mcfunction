#> sgp.kits:pyromane_fire/creation
# @dummy
# @environment sgp.ci:pyromane_fire
#
# Detonation creates a full-duration fire carrying the projectile's owner and removes its interaction target.

function sgp.ci:pyromane_fire/fixture
summon interaction ~0.5 ~1 ~0.5 {Tags:["sgp.ci.fire","sgp.tnt_interaction"]}
function sgp.ci:pyromane_fire/create {owner:91001,x:"~0.5"}
execute store result score #ci.fire.count sgp.dummy if entity @e[tag=sgp.ci.fire,distance=..24,type=marker]
assert score #ci.fire.count sgp.dummy matches 1
assert entity @e[tag=sgp.ci.fire,tag=sgp.fire_explosion,scores={sgp.timer=100,sgp.damage_owner=91001},distance=..24,type=marker]
assert not entity @e[tag=sgp.ci.fire,type=interaction]

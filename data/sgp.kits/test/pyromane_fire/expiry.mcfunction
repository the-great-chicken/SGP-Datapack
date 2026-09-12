#> sgp.kits:pyromane_fire/expiry
# @dummy
# @environment sgp.ci:pyromane_fire
#
# Fire exists for its remaining updates and disappears when its duration expires.

function sgp.ci:pyromane_fire/fixture
summon marker ~0.5 ~1 ~0.5 {Tags:["sgp.ci.fire","sgp.marker"]}
scoreboard players set @e[tag=sgp.ci.fire,type=marker] sgp.timer 2
scoreboard players set @e[tag=sgp.ci.fire,type=marker] sgp.damage_owner 91001
function sgp.ci:pyromane_fire/tick
assert entity @e[tag=sgp.ci.fire,type=marker]
function sgp.ci:pyromane_fire/tick
assert not entity @e[tag=sgp.ci.fire,type=marker]

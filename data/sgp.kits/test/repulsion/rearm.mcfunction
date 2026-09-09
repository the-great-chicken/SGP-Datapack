#> sgp.kits:repulsion/rearm
# @dummy
# @environment sgp.ci:repulsion/rearm
#
# The wearer can trigger another impulse after the first trigger has been consumed.

function sgp.ci:repulsion/scenarios/rearm/1
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
function sgp.ci:repulsion/scenarios/rearm/2
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
function sgp.ci:repulsion/scenarios/rearm/3

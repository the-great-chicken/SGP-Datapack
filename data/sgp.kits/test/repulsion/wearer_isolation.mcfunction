#> sgp.kits:repulsion/wearer_isolation
# @dummy
# @environment sgp.ci:repulsion/wearer_isolation
#
# Triggering one wearer leaves a nearby equipped wearer stationary.

function sgp.ci:repulsion/scenarios/wearer_isolation/1
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
function sgp.ci:repulsion/scenarios/wearer_isolation/2

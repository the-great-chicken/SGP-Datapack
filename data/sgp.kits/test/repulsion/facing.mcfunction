#> sgp.kits:repulsion/facing
# @dummy
# @environment sgp.ci:repulsion/facing
#
# Turning west makes the backward impulse point east.

function sgp.ci:repulsion/scenarios/facing/1
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
function sgp.ci:repulsion/scenarios/facing/2

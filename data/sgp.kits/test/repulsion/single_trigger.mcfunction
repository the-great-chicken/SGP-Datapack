#> sgp.kits:repulsion/single_trigger
# @dummy
# @environment sgp.ci:repulsion/single_trigger
#
# One trigger launches the wearer backward and clears the trigger.

function sgp.ci:repulsion/scenarios/single_trigger/1
await entity @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,scores={sgp.trigger_repulsion=0},type=husk]
function sgp.ci:repulsion/scenarios/single_trigger/2

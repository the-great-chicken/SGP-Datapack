#> sgp.ci:pco/cleanup
# Cancel pending cage work and restore the configuration after the batch.

function #bs.schedule:cancel_all {with:{id:"pco"}}
kill @e[tag=sgp.ci.pco,type=marker]
function sgp.ci:players/cleanup
data modify storage sgp:data majeurs.pco set from storage sgp.ci:pco previous.configuration
execute store result score #pco_phase sgp.dummy run data get storage sgp.ci:pco previous.phase
execute store result score #rounds sgp.dummy run data get storage sgp.ci:pco previous.rounds
execute store result score #pco_max_rounds sgp.dummy run data get storage sgp.ci:pco previous.max_rounds
data remove storage sgp.ci:pco previous

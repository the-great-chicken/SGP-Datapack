#> sgp.ci:pco/setup
# Preserve the configuration and round counters used by the cage scenarios.

function sgp.ci:players/cleanup
data modify storage sgp.ci:pco previous set value {}
data modify storage sgp.ci:pco previous.configuration set from storage sgp:data majeurs.pco
execute store result storage sgp.ci:pco previous.phase int 1 run scoreboard players get #pco_phase sgp.dummy
execute store result storage sgp.ci:pco previous.rounds int 1 run scoreboard players get #rounds sgp.dummy
execute store result storage sgp.ci:pco previous.max_rounds int 1 run scoreboard players get #pco_max_rounds sgp.dummy

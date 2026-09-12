#> sgp.ci:protect/setup
# Preserve the event counters used by the combat scenarios.

function sgp.ci:players/cleanup
data modify storage sgp.ci:protect previous set value {}
execute store result storage sgp.ci:protect previous.phase int 1 run scoreboard players get #protect_phase sgp.dummy
execute store result storage sgp.ci:protect previous.rounds int 1 run scoreboard players get #rounds sgp.dummy
execute store result storage sgp.ci:protect previous.max_rounds int 1 run scoreboard players get #protect_max_rounds sgp.dummy
execute store result storage sgp.ci:protect previous.red_chosen int 1 run scoreboard players get #king_rouge_chosen sgp.dummy
execute store result storage sgp.ci:protect previous.blue_chosen int 1 run scoreboard players get #king_bleu_chosen sgp.dummy
execute store result storage sgp.ci:protect previous.red_dead int 1 run scoreboard players get #mort_roi_rouge_annoncee sgp.dummy
execute store result storage sgp.ci:protect previous.blue_dead int 1 run scoreboard players get #mort_roi_bleue_annoncee sgp.dummy
execute store result storage sgp.ci:protect previous.seconds int 1 run scoreboard players get #second sgp.timer

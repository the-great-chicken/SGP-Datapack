#> sgp.ci:protect/cleanup

function #bs.schedule:cancel_all {with:{id:"major_event"}}
kill @e[tag=sgp.ci.protect,type=marker]
function sgp.ci:players/cleanup
execute store result score #protect_phase sgp.dummy run data get storage sgp.ci:protect previous.phase
execute store result score #rounds sgp.dummy run data get storage sgp.ci:protect previous.rounds
execute store result score #protect_max_rounds sgp.dummy run data get storage sgp.ci:protect previous.max_rounds
execute store result score #king_rouge_chosen sgp.dummy run data get storage sgp.ci:protect previous.red_chosen
execute store result score #king_bleu_chosen sgp.dummy run data get storage sgp.ci:protect previous.blue_chosen
execute store result score #mort_roi_rouge_annoncee sgp.dummy run data get storage sgp.ci:protect previous.red_dead
execute store result score #mort_roi_bleue_annoncee sgp.dummy run data get storage sgp.ci:protect previous.blue_dead
execute store result score #second sgp.timer run data get storage sgp.ci:protect previous.seconds
data remove storage sgp.ci:protect previous

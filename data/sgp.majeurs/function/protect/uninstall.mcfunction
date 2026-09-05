#> sgp.majeurs:protect/uninstall
#
# Remove Protect-owned runtime state and teams.

function sgp.majeurs:protect/close_king_selector {side:rouge}
function sgp.majeurs:protect/close_king_selector {side:bleu}

scoreboard players reset #protect_phase sgp.dummy
scoreboard players reset #king_rouge_chosen sgp.dummy
scoreboard players reset #king_bleu_chosen sgp.dummy
scoreboard players reset #mort_roi_rouge_annoncee sgp.dummy
scoreboard players reset #mort_roi_bleue_annoncee sgp.dummy

team remove sgp.rouge
team remove sgp.bleue

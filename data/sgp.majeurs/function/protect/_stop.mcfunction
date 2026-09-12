#> sgp.majeurs:protect/_stop
#
# Stop the active Protéger le Roi round and release its owned state.

execute unless score #protect_phase sgp.dummy matches 1..2 run return 0

function sgp.majeurs:protect/close_king_selector {side:rouge}
function sgp.majeurs:protect/close_king_selector {side:bleu}

execute as @a[tag=sgp.major_participant] run function sgp.majeurs:protect/reset_player_state
# Kings that were already eliminated are spectators; their role tags are still
# Protect-owned and should not survive the round.
tag @a remove sgp.roi_rouge
tag @a remove sgp.roi_bleu

scoreboard players set #king_rouge_chosen sgp.dummy 0
scoreboard players set #king_bleu_chosen sgp.dummy 0
scoreboard players set #mort_roi_rouge_annoncee sgp.dummy 0
scoreboard players set #mort_roi_bleue_annoncee sgp.dummy 0

function #sgp.hooks:discord/majeurs/protect/_stop_1
function sgp.majeurs:common/stop
team empty sgp.rouge
team empty sgp.bleue
scoreboard players set #protect_phase sgp.dummy 0
function sgp.majeurs:common/rounds with storage sgp:data majeurs.protect

#> sgp.misc:actionbar/progress_bar/append
#
# Appends the precomputed gold/white progress bar corresponding to
# #sgp.ab.filled in sgp.dummy to dah:actbar new.text.

execute store result storage sgp:macro actionbar_progress.index int 1 run scoreboard players get #sgp.ab.filled sgp.dummy
data modify storage sgp:macro actionbar_progress.function set value "sgp.misc:actionbar/progress_bar/apply"
data modify storage sgp:macro actionbar_progress.list set value "sgp:data misc.actionbar.progress_bar.bars"

function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_progress
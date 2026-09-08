#> sgp.majeurs:protect/selection/denied_requests
# @dummy
# @environment sgp.ci:protect/selection/denied_requests
#
# Opponents, nonparticipants, and requests outside selection cannot claim the crown.

function sgp.ci:protect/selection_fixture
execute as PrBlueKing run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.rouge,limit=1,type=interaction] data.args
execute as PrRedKing run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.bleu,limit=1,type=interaction] data.args
tag PrRedA remove sgp.major_participant
execute as PrRedA run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.rouge,limit=1,type=interaction] data.args
scoreboard players set #protect_phase sgp.dummy 0
execute as PrRedKing run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.rouge,limit=1,type=interaction] data.args
scoreboard players set #protect_phase sgp.dummy 2
execute as PrBlueKing run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.bleu,limit=1,type=interaction] data.args
assert not entity @a[tag=sgp.roi_rouge]
assert not entity @a[tag=sgp.roi_bleu]
assert score #king_rouge_chosen sgp.dummy matches 0
assert score #king_bleu_chosen sgp.dummy matches 0
assert not chat ".*est le roi.*" @s

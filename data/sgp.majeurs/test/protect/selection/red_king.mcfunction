#> sgp.majeurs:protect/selection/red_king
# @dummy
# @environment sgp.ci:protect/selection/red_king
#
# The selector chooses one participant for its own team; repeated requests cannot replace the king or start combat early.

function sgp.ci:protect/selection_fixture
execute as PrRedKing run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.rouge,limit=1,type=interaction] data.args
assert entity @a[name=PrRedKing,tag=sgp.roi_rouge]
assert score #king_rouge_chosen sgp.dummy matches 1
assert score #king_bleu_chosen sgp.dummy matches 0
assert score #protect_phase sgp.dummy matches 1
assert chat ".*PrRedKing est le roi Rouge.*" @s

execute as PrRedKing run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.rouge,limit=1,type=interaction] data.args
execute as PrRedA run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.rouge,limit=1,type=interaction] data.args
execute store result score #ci.protect.kings sgp.dummy if entity @a[tag=sgp.roi_rouge]
assert score #ci.protect.kings sgp.dummy matches 1
assert not entity @a[name=PrRedA,tag=sgp.roi_rouge]
assert score #protect_phase sgp.dummy matches 1

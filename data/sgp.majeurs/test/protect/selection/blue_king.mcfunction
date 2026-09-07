#> sgp.majeurs:protect/selection/blue_king
# @dummy
# @environment sgp.ci:protect
#
# The selector chooses one participant for its own team; repeated requests cannot replace the king or start combat early.

function sgp.ci:protect/selection_fixture
execute as PrBlueKing run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.bleu,limit=1,type=interaction] data.args
assert entity @a[name=PrBlueKing,tag=sgp.roi_bleu]
assert score #king_bleu_chosen sgp.dummy matches 1
assert score #king_rouge_chosen sgp.dummy matches 0
assert score #protect_phase sgp.dummy matches 1
assert chat ".*PrBlueKing est le roi Bleu.*" @s

execute as PrBlueKing run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.bleu,limit=1,type=interaction] data.args
execute as PrBlueA run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.bleu,limit=1,type=interaction] data.args
execute store result score #ci.protect.kings sgp.dummy if entity @a[tag=sgp.roi_bleu]
assert score #ci.protect.kings sgp.dummy matches 1
assert not entity @a[name=PrBlueA,tag=sgp.roi_bleu]
assert score #protect_phase sgp.dummy matches 1

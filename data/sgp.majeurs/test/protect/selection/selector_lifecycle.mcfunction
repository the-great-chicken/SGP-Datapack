#> sgp.majeurs:protect/selection/selector_lifecycle
# @dummy
# @environment sgp.ci:protect/selection/selector_lifecycle
#
# Rebuilding replaces the interaction target; closing red leaves blue selection available.

function sgp.ci:protect/selection_fixture
execute as @e[tag=sgp.ci.protect,name=devenir_roi_rouge,distance=..40,type=marker] at @s run function sgp.majeurs:protect/setup_king_selector {side:rouge,team:rouge,name:Rouge,color:dark_red}
execute store result score #ci.protect.selectors sgp.dummy if entity @e[tag=sgp.protect.king_selector.rouge,distance=..40,type=interaction]
assert score #ci.protect.selectors sgp.dummy matches 1
function sgp.majeurs:protect/close_king_selector {side:rouge}
assert not entity @e[tag=sgp.protect.king_selector.rouge,distance=..40,type=interaction]
assert entity @e[tag=sgp.protect.king_selector.bleu,distance=..40,type=interaction]
assert score #protect_phase sgp.dummy matches 1
assert score #king_bleu_chosen sgp.dummy matches 0
assert entity @a[name=PrBlueKing,tag=sgp.major_participant,team=sgp.bleue]
assert data entity @e[tag=sgp.protect.king_selector.bleu,distance=..40,limit=1,type=interaction] data.args{side:"bleu",team:"bleue",name:"Bleu",color:"dark_blue"}
execute as PrBlueKing run function sgp.majeurs:protect/select_king with entity @e[tag=sgp.protect.king_selector.bleu,distance=..40,limit=1,type=interaction] data.args
assert entity @a[name=PrBlueKing,tag=sgp.roi_bleu]
assert score #king_rouge_chosen sgp.dummy matches 0

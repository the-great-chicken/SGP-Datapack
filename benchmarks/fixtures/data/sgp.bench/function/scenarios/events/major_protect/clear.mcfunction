#> sgp.bench:scenarios/events/major_protect/clear
function #bs.schedule:cancel_all {with:{id:"major_event"}}
schedule clear sgp.majeurs:protect/_start
kill @e[tag=sgp.protect.king_selector,type=interaction]
kill @e[tag=sgp.bench.protect,type=marker]
setblock -11 82 -20 air
setblock -11 82 -19 air
setblock 10 82 -20 air
setblock 10 82 -19 air
scoreboard players set #protect_phase sgp.dummy 0
scoreboard players set #king_rouge_chosen sgp.dummy 0
scoreboard players set #king_bleu_chosen sgp.dummy 0
scoreboard players set #rounds sgp.dummy 0
team empty sgp.rouge
team empty sgp.bleue

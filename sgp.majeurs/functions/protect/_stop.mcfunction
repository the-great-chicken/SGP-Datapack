tag @a remove roi_rouge
tag @a remove roi_bleu
execute as @a run trigger sgp.devenir_roi_bleu set 0
execute as @a run trigger sgp.devenir_roi_rouge set 0
fill 2537 253 2203 2537 251 2193 minecraft:air
setblock 2480 230 2166 air replace
useglow toggle
function sgp.majeurs:common/stop
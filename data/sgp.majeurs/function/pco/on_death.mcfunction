#> sgp.majeurs:pco/on_death
# `{color, color_material, color_hex, team}`
#
# Prepare a dead player for capture and defer the cage teleport by one tick.

$function sgp.majeurs:pco/kit {color:"$(color)", color_material:"$(color_material)", color_hex:"$(color_hex)"}

effect give @s resistance infinite 5 true
scoreboard players set @s sgp.en_cage 1
tag @s add sgp.pco.awaiting_cage

$function #bs.schedule:schedule {run:"function sgp.majeurs:pco/cage/capture {team:$(team)}",with:{id:"pco",time:1,unit:"t"}}
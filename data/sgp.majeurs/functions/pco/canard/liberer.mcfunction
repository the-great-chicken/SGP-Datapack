fill 2478 244 2138 2484 244 2140 air
effect clear @a[team=sgp.Canard] minecraft:resistance
tellraw @a[team=sgp.Canard] {"text":"Vous avez réussi à libérer tous vos congénères !","color":"green","bold":true}
title @a[team=sgp.Canard] title {"text":"Libération :D","color":"green","bold":true}
tellraw @a[team=sgp.Poule] {"text":"Les Canards se sont évadés !","color":"green","bold":true}
title @a[team=sgp.Poule] title {"text":"Évasion D:","color":"green","bold":true}
schedule function sgp.majeurs:pco/canard/clone_cages 60t
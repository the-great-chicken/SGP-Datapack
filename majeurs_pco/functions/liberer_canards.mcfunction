fill 2478 244 2138 2484 244 2140 air
effect clear @a[team=Canard] minecraft:resistance
tellraw @a[team=Canard] {"text":"Vous avez réussi à libérer tous vos congénères !","color":"green","bold":true}
title @a[team=Canard] title {"text":"Libération :D","color":"green","bold":true}
tellraw @a[team=Poule] {"text":"Les Canards se sont évadés !","color":"green","bold":true}
title @a[team=Poule] title {"text":"Évasion D:","color":"green","bold":true}
schedule function majeurs_pco:clone_cage_canards 60t
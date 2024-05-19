fill 2497 239 2183 2500 239 2186 air
effect clear @a[team=Poule] minecraft:resistance
tellraw @a[team=Poule] {"text":"Vous avez réussi à libérer tous vos congénères !","color":"red","bold":true}
title @a[team=Poule] title {"text":"Libération :D","color":"red","bold":true}
tellraw @a[team=Oie] {"text":"Les Poules se sont évadées !","color":"red","bold":true}
title @a[team=Oie] title {"text":"Évasion D:","color":"red","bold":true}
schedule function majeurs_pco:clone_cage_poules 60t
fill 2497 239 2183 2500 239 2186 air
effect clear @a[team=sgp.Poule] minecraft:resistance
tellraw @a[team=sgp.Poule] {"text":"Vous avez réussi à libérer tous vos congénères !","color":"red","bold":true}
title @a[team=sgp.Poule] title {"text":"Libération :D","color":"red","bold":true}
tellraw @a[team=sgp.Oie] {"text":"Les Poules se sont évadées !","color":"red","bold":true}
title @a[team=sgp.Oie] title {"text":"Évasion D:","color":"red","bold":true}
schedule function sgp.majeurs:pco/poule/clone_cages 60t
fill 2527 248 2141 2531 248 2144 air
effect clear @a[team=Oie] minecraft:resistance
tellraw @a[team=Oie] {"text":"Vous avez réussi à libérer tous vos congénères !","color":"yellow","bold":true}
title @a[team=Oie] title {"text":"Libération :D","color":"yellow","bold":true}
tellraw @a[team=Canard] {"text":"Les Oies se sont évadées !","color":"yellow","bold":true}
title @a[team=Canard] title {"text":"Évasion D:","color":"yellow","bold":true}
schedule function sgp.majeurs:pco/oie/clone_cages 60t
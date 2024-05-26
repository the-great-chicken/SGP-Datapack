fill 2527 248 2141 2531 248 2144 air
effect clear @a[team=sgp.Oie] minecraft:resistance
tellraw @a[team=sgp.Oie] {"text":"Vous avez réussi à libérer tous vos congénères !","color":"yellow","bold":true}
title @a[team=sgp.Oie] title {"text":"Libération :D","color":"yellow","bold":true}
tellraw @a[team=sgp.Canard] {"text":"Les sgp.Oies se sont évadées !","color":"yellow","bold":true}
title @a[team=sgp.Canard] title {"text":"Évasion D:","color":"yellow","bold":true}
schedule function sgp.majeurs:pco/oie/clone_cages 60t
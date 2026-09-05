#> sgp.majeurs:pco/cage/uncage
# `{cage, team, catchers, team_color}`
#
# Release the captured members of one team, then schedule the cage restoration.

$scoreboard players reset @a sgp.liberer_$(cage)s
$tag @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_$(cage)_cage_arena",limit=1,type=marker] add sgp.pco.cage_open
$execute as @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_uncage_storage",nbt={data:{cage:"$(cage)"}},limit=1,type=marker] run function sgp.majeurs:pco/cage/compute_markers_coordinates
$execute as @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_uncage_storage",nbt={data:{cage:"$(cage)"}},limit=1,type=marker] run function sgp.majeurs:pco/cage/clone_cage with entity @s data

$effect clear @a[team=sgp.$(team)] minecraft:resistance
$tp @a[team=sgp.$(team),scores={sgp.en_cage=1}] @s
$scoreboard players set @a[team=sgp.$(team)] sgp.en_cage 0

$tellraw @a[team=sgp.$(team)] {text:"Vous avez réussi à libérer tous vos congénères !", color:"$(team_color)", bold:true}
$title @a[team=sgp.$(team)] title {text:"Libération :D", color:"$(team_color)", bold:true}

$tellraw @a[team=sgp.$(catchers)] {text:"Les $(team)s se sont évadé(e)s !", color:"$(team_color)", bold:true}
$title @a[team=sgp.$(catchers)] title {text:"Évasion D:", color:"$(team_color)", bold:true}

$execute as @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_$(cage)_cage_arena",limit=1,type=marker] \
    run function #bs.schedule:schedule {run:"function sgp.majeurs:pco/cage/restore {cage:$(cage)}",with:{id:"pco",time:3,unit:"s"}}

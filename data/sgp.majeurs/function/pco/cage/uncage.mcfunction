#> sgp.majeurs:pco/uncage
# `{cage, team, catchers, team_color}`
#
# Handle actions when a team ("Poule," "Canard," or "Oie") is uncaged. 
# This function clears resistance effects from the uncaged team, 
# sends congratulatory messages, and respawns their cage after a short delay.

$execute as @e[type=marker,tag=sgp.marker,name="pco_uncage_storage",nbt={data:{cage:$(cage)}}] \
    run function sgp.majeurs:pco/cage/compute_markers_coordinates

$execute as @e[type=marker,tag=sgp.marker,name="pco_uncage_storage",nbt={data:{cage:$(cage)}}] \
    run function sgp.majeurs:pco/cage/clone_cage with entity @s data


$effect clear @a[team=sgp.$(team)] minecraft:resistance

$tellraw @a[team=sgp.$(team)] {"text":"Vous avez réussi à libérer tous vos congénères !","color":"$(team_color)","bold":true}
$title @a[team=sgp.$(team)] title {"text":"Libération :D","color":"$(team_color)","bold":true}

$tellraw @a[team=sgp.$(catchers)] {"text":"Les $(team)s se sont évadées !","color":"$(team_color)","bold":true}
$title @a[team=sgp.$(catchers)] title {"text":"Évasion D:","color":"$(team_color)","bold":true}

$function #bs.schedule:schedule {with:{command:"execute as @e[type=marker,tag=sgp.marker,name='pco_cage_storage',nbt={data:{cage:$(cage)}}] run function sgp.majeurs:pco/cage/clone_cage with entity @s data",time:3,unit:"s"}}
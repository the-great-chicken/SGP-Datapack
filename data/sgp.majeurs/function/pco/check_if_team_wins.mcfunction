$execute as @e[type=marker,tag=sgp.marker,name='pco_$(cage)_cage_arena',limit=1] at @s \
    as @a[team=sgp.$(team)] \
        run function sgp.majeurs:pco/cage/check_if_inside \
            with entity @e[type=marker,tag=sgp.marker,name='pco_cage_storage',nbt={data:{cage:'$(cage)'}},limit=1] data

$execute as @a[team=sgp.$(team)] run scoreboard players add #$(cage)s_joueurs sgp.dummy 1
$execute as @a[team=sgp.$(team),scores={sgp.en_cage=1}] run scoreboard players add #$(cage)s sgp.en_cage 1

$execute if score #$(cage)s sgp.en_cage = #$(cage)s_joueurs sgp.dummy \
    run function sgp.majeurs:pco/_stop
$execute if score #$(cage)s sgp.en_cage = #$(cage)s_joueurs sgp.dummy \
    run title @a[tag=sgp.in_game] title {$(text_and_color), "bold":true}

$scoreboard players set #$(cage)s_joueurs sgp.dummy 0
$scoreboard players set #$(cage)s sgp.en_cage 0
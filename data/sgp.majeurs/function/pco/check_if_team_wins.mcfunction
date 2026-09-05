#> sgp.majeurs:pco/check_if_team_wins
# `{team, cage, winner_name, winner_color}`
#
# Check if every player from a team is in the cage
# and stop the game if it's the case.

scoreboard players set #pco_team_size sgp.dummy 0
scoreboard players set #pco_caged sgp.dummy 0

$execute at @e[type=marker,tag=sgp.marker,tag=sgp.pco.active,name="pco_$(cage)_cage_arena",limit=1] \
    as @a[team=sgp.$(team)] \
        run function sgp.majeurs:pco/cage/check_if_inside

$execute as @a[team=sgp.$(team)] \
    run scoreboard players add #pco_team_size sgp.dummy 1

$execute as @a[team=sgp.$(team),scores={sgp.en_cage=1}] \
    run scoreboard players add #pco_caged sgp.dummy 1

execute unless score #pco_caged sgp.dummy = #pco_team_size sgp.dummy run return 0

$tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"$(winner_name) !", color:"$(winner_color)", bold:true}]
$title @a[tag=sgp.in_game] title {text:"$(winner_name)", color:"$(winner_color)", bold:true}

function sgp.majeurs:pco/_stop

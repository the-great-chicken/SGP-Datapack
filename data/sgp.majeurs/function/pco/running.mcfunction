#> sgp.majeurs:pco/running
#
# Run the active PCO round.

execute unless score #pco_phase sgp.dummy matches 2 run return 0

# Check if all members of a team left the game
execute unless entity @a[team=sgp.Poule] run function sgp.majeurs:pco/check_team_eliminated {team:Poule,name_ennemies:Oies,color_ennemies:yellow,victory:victorieuses}
execute unless score #pco_phase sgp.dummy matches 2 run return 1
execute unless entity @a[team=sgp.Canard] run function sgp.majeurs:pco/check_team_eliminated {team:Canard,name_ennemies:Poules,color_ennemies:red,victory:victorieuses}
execute unless score #pco_phase sgp.dummy matches 2 run return 1
execute unless entity @a[team=sgp.Oie] run function sgp.majeurs:pco/check_team_eliminated {team:Oie,name_ennemies:Canards,color_ennemies:green,victory:victorieux}
execute unless score #pco_phase sgp.dummy matches 2 run return 1

function sgp.majeurs:pco/empower
function sgp.majeurs:pco/check_death
execute as @a[tag=sgp.major_participant] run function sgp.majeurs:pco/cabane/run_check_inside

# Activer/désactiver le fait de pouvoir cliquer sur les panneaux de libération
execute at @e[tag=sgp.marker,tag=sgp.pco.active,tag=!sgp.pco.cage_open,name="pco_oie_cage_arena",limit=1,type=marker] \
    positioned ~1 ~ ~1 \
        as @a[team=sgp.Oie] \
            run function sgp.majeurs:pco/cage/check_can_uncage {team:"oie"}

execute at @e[tag=sgp.marker,tag=sgp.pco.active,tag=!sgp.pco.cage_open,name="pco_canard_cage_arena",limit=1,type=marker] \
    positioned ~1 ~ ~1 \
        as @a[team=sgp.Canard] \
            run function sgp.majeurs:pco/cage/check_can_uncage {team:"canard"}

execute at @e[tag=sgp.marker,tag=sgp.pco.active,tag=!sgp.pco.cage_open,name="pco_poule_cage_arena",limit=1,type=marker] \
    positioned ~1 ~ ~1 \
        as @a[team=sgp.Poule] \
            run function sgp.majeurs:pco/cage/check_can_uncage {team:"poule"}

# Si on clique sur un panneau de libération
execute as @a[tag=sgp.major_participant,team=sgp.Oie,scores={sgp.liberer_oies=2},sort=random,limit=1] \
    run function sgp.majeurs:pco/cage/uncage {cage:oie, team:Oie, team_color:yellow, catchers:Canard}

execute as @a[tag=sgp.major_participant,team=sgp.Poule,scores={sgp.liberer_poules=2},sort=random,limit=1] \
    run function sgp.majeurs:pco/cage/uncage {cage:poule, team:Poule, team_color:red, catchers:Oie}

execute as @a[tag=sgp.major_participant,team=sgp.Canard,scores={sgp.liberer_canards=2},sort=random,limit=1] \
    run function sgp.majeurs:pco/cage/uncage {cage:canard, team:Canard, team_color:green, catchers:Poule}


# Check si des joueurs sont en cage, et si tous les joueurs d'une équipe le sont, la partie se termine
function sgp.majeurs:pco/check_if_team_wins {cage:poule, team:Poule, winner_name:"Oies victorieuses", winner_color:yellow}
execute unless score #pco_phase sgp.dummy matches 2 run return 1
function sgp.majeurs:pco/check_if_team_wins {cage:canard, team:Canard, winner_name:"Poules victorieuses", winner_color:red}
execute unless score #pco_phase sgp.dummy matches 2 run return 1
function sgp.majeurs:pco/check_if_team_wins {cage:oie, team:Oie, winner_name:"Canards victorieux", winner_color:green}
execute unless score #pco_phase sgp.dummy matches 2 run return 1

#> sgp.majeurs:pco/running
#
# Executed each tick, run functions like:
# checking if someone should be able to uncage,
# checking if someone clicked on the uncage sign,
# checking if a team won

function sgp.majeurs:pco/empower

function sgp.majeurs:pco/check_death

execute as @a[tag=sgp.in_game] \
    run function sgp.majeurs:pco/cabane/run_check_inside

# Activer/désactiver le fait de pouvoir cliquer sur les panneaux de libération
execute as @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_oie_cage_arena",limit=1] at @s positioned ~1 ~ ~1 \
    as @a[team=sgp.Oie] \
        run function sgp.majeurs:pco/cage/check_can_uncage {team:"oie"}

execute as @a[team=sgp.Oie,scores={sgp.liberer_oies=1,sgp.en_cage=1}] \
    run trigger sgp.liberer_oies set 0


execute as @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_canard_cage_arena",limit=1] at @s positioned ~1 ~ ~1 \
    as @a[team=sgp.Canard] \
        run function sgp.majeurs:pco/cage/check_can_uncage {team:"canard"}

execute as @a[team=sgp.Canard,scores={sgp.liberer_canards=1,sgp.en_cage=1}] \
    run trigger sgp.liberer_canards set 0


execute as @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_poule_cage_arena",limit=1] at @s positioned ~1 ~ ~1 \
    as @a[team=sgp.Poule] \
        run function sgp.majeurs:pco/cage/check_can_uncage {team:"poule"}

execute as @a[team=sgp.Poule,scores={sgp.liberer_poules=1,sgp.en_cage=1}] \
    run trigger sgp.liberer_poules set 0


# Si on clique sur un panneau de libération
execute as @a[scores={sgp.liberer_oies=2}] \
    run function sgp.majeurs:pco/cage/uncage {cage:oie, team:Oie, team_color:yellow, catchers:Canard}

execute as @a[scores={sgp.liberer_oies=2}] \
    run scoreboard players set @a[tag=sgp.in_game] sgp.liberer_oies 0


execute as @a[scores={sgp.liberer_oies=2}] \
    run function sgp.majeurs:pco/cage/uncage {cage:poule, team:Poule, team_color:red, catchers:Oie}

execute as @a[scores={sgp.liberer_poules=2}] \
    run scoreboard players set @a[tag=sgp.in_game] sgp.liberer_poules 0


execute as @a[scores={sgp.liberer_oies=2}] \
    run function sgp.majeurs:pco/cage/uncage {cage:canard, team:Canard, team_color:green, catchers:Poule}

execute as @a[scores={sgp.liberer_canards=2}] \
    run scoreboard players set @a[tag=sgp.in_game] sgp.liberer_canards 0


# Check si des joueurs sont en cage, et si tous les joueurs d'une équipe le sont, la partie se termine
function sgp.majeurs:pco/check_if_team_wins {cage:poule, team:Poule, text_and_color:"\"text\":\"Oies Victorieuses\", \"color\":\"yellow\""}

function sgp.majeurs:pco/check_if_team_wins {cage:canard, team:Canard, text_and_color:"\"text\":\"Poules Victorieuses\", \"color\":\"red\""}

function sgp.majeurs:pco/check_if_team_wins {cage:oie, team:Oie, text_and_color:"\"text\":\"Canards Victorieux\", \"color\":\"green\""}

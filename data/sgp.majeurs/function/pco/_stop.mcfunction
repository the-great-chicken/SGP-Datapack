#> sgp.majeurs:pco/_stop
# Stop the active PCO round and release all PCO-owned state.

execute unless score #pco_phase sgp.dummy matches 1..2 run return 0
function #bs.schedule:cancel_all {with:{id:"pco"}}

# Remove the cages
execute as @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_uncage_storage",type=marker] \
    run function sgp.majeurs:pco/cage/compute_markers_coordinates

execute as @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_uncage_storage",type=marker] \
    run function sgp.majeurs:pco/cage/clone_cage with entity @s data

execute as @a run function sgp.majeurs:pco/reset_player_state

move @a[tag=sgp.major_participant] #Morts

function sgp.majeurs:common/stop

team empty sgp.Oie
team empty sgp.Poule
team empty sgp.Canard

tag @e[tag=sgp.pco.cage_open,type=marker] remove sgp.pco.cage_open
tag @e[tag=sgp.pco.active,type=marker] remove sgp.pco.active

data remove storage sgp:data majeurs.pco.active_location

scoreboard players reset #pco_dispatch_team sgp.dummy
scoreboard players reset #pco_team_size sgp.dummy
scoreboard players reset #pco_caged sgp.dummy

scoreboard players set #pco_phase sgp.dummy 0

function sgp.majeurs:common/rounds with storage sgp:data majeurs.pco

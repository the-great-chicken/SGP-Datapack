#> sgp.majeurs:pco/uninstall
#
# Remove PCO-owned runtime state, objectives, teams, and transient marker tags.

function #bs.schedule:cancel_all {with:{id:"pco"}}
execute as @a run function sgp.majeurs:pco/cabane/actionbar_clear
tag @e[tag=sgp.pco.active,type=marker] remove sgp.pco.active

scoreboard players reset #pco_phase sgp.dummy
scoreboard players reset #pco_registered_markers sgp.dummy
scoreboard players reset #pco_pos_x sgp.dummy
scoreboard players reset #pco_pos_y sgp.dummy
scoreboard players reset #pco_pos_z sgp.dummy
scoreboard players reset #pco_end_x sgp.dummy
scoreboard players reset #pco_end_y sgp.dummy
scoreboard players reset #pco_end_z sgp.dummy
scoreboard players reset #sgp.ab.width.pco_cabane sgp.dummy

team remove sgp.Oie
team remove sgp.Poule
team remove sgp.Canard

scoreboard objectives remove sgp.liberer_oies
scoreboard objectives remove sgp.liberer_poules
scoreboard objectives remove sgp.liberer_canards
scoreboard objectives remove sgp.temps_cabane_pco
scoreboard objectives remove sgp.temps_cabane_pco_secondes
scoreboard objectives remove sgp.en_cage
scoreboard objectives remove sgp.ab.pco_cabane

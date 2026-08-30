#> sgp.majeurs:uninstall

# Stop the scheduler, pending rounds, and any active event before removing state.
function sgp.majeurs:scheduler/abort

# ---------- Remove Objectives ----------

scoreboard objectives remove sgp.devenir_roi_rouge
scoreboard objectives remove sgp.devenir_roi_bleu

scoreboard objectives remove sgp.liberer_oies
scoreboard objectives remove sgp.liberer_poules
scoreboard objectives remove sgp.liberer_canards

scoreboard objectives remove sgp.temps_cabane_pco
scoreboard objectives remove sgp.temps_cabane_pco_secondes
scoreboard objectives remove sgp.en_cage

scoreboard objectives remove sgp.posx1
scoreboard objectives remove sgp.posy1
scoreboard objectives remove sgp.posz1
scoreboard objectives remove sgp.posx
scoreboard objectives remove sgp.posy
scoreboard objectives remove sgp.posz

scoreboard objectives remove sgp.link_teams



# ---------- Remove Teams ----------

team remove sgp.rouge
team remove sgp.bleue
team remove sgp.Oie
team remove sgp.Poule
team remove sgp.Canard



# ---------- Remove Storages -----------

data remove storage sgp:data majeurs

#> sgp.majeurs:initialization


# ---------- Create Objectives ----------

scoreboard objectives add sgp.liberer_oies trigger
scoreboard objectives add sgp.liberer_poules trigger
scoreboard objectives add sgp.liberer_canards trigger

scoreboard objectives add sgp.temps_cabane_pco dummy
scoreboard objectives add sgp.temps_cabane_pco_secondes dummy
scoreboard objectives add sgp.en_cage dummy

scoreboard objectives add sgp.posx1 dummy
scoreboard objectives add sgp.posy1 dummy
scoreboard objectives add sgp.posz1 dummy
scoreboard objectives add sgp.posx dummy
scoreboard objectives add sgp.posy dummy
scoreboard objectives add sgp.posz dummy

scoreboard objectives add sgp.link_teams dummy
scoreboard objectives add sgp.teammate_deaths dummy



# ---------- Initialize Values ----------

# Events start time
execute unless score #pco_hour sgp.dummy matches 0..23 \
    run scoreboard players set #pco_hour sgp.dummy 22
execute unless score #pco_minute sgp.dummy matches 0..59 \
    run scoreboard players set #pco_minute sgp.dummy 0

execute unless score #hide_and_seek_hour sgp.dummy matches 0..23 \
    run scoreboard players set #hide_and_seek_hour sgp.dummy 22
execute unless score #hide_and_seek_minute sgp.dummy matches 0..59 \
    run scoreboard players set #hide_and_seek_minute sgp.dummy 45

execute unless score #protect_hour sgp.dummy matches 0..23 \
    run scoreboard players set #protect_hour sgp.dummy 23
execute unless score #protect_minute sgp.dummy matches 0..59 \
    run scoreboard players set #protect_minute sgp.dummy 30

# Events rounds count
execute unless score #pco_max_rounds sgp.dummy matches 1.. \
    run scoreboard players set #pco_max_rounds sgp.dummy 3
execute unless score #hide_and_seek_max_rounds sgp.dummy matches 1.. \
    run scoreboard players set #hide_and_seek_max_rounds sgp.dummy 3
execute unless score #protect_max_rounds sgp.dummy matches 1.. \
    run scoreboard players set #protect_max_rounds sgp.dummy 3

function sgp.majeurs:config/recompute_announcement {event:"pco"}
function sgp.majeurs:config/recompute_announcement {event:"hide_and_seek"}
function sgp.majeurs:config/recompute_announcement {event:"protect"}



# ---------- Create Teams ----------
function #sgp.majeurs:events/initialization

team add sgp.Oie
team modify sgp.Oie collisionRule never
team modify sgp.Oie color yellow
team modify sgp.Oie friendlyFire false

team add sgp.Poule
team modify sgp.Poule collisionRule never
team modify sgp.Poule color red
team modify sgp.Poule friendlyFire false

team add sgp.Canard
team modify sgp.Canard collisionRule never
team modify sgp.Canard color green
team modify sgp.Canard friendlyFire false

team add sgp.hider "Volaille"
team modify sgp.hider collisionRule pushOtherTeams
team modify sgp.hider nametagVisibility never
team modify sgp.hider color yellow

team add sgp.seeker "Chasseurs"
team modify sgp.seeker friendlyFire false
team modify sgp.seeker color dark_green



# ---------- Initialize Storages ----------

data modify storage sgp:data majeurs merge value {pco:{event:"pco",text:"Poule Canard Oie"},protect:{event:"protect",text:"Protéger le Roi"},hide_and_seek:{event:"hide_and_seek",text:"Cache-cache",end:{seeker:"Que la chasse à la volaille commence !",hider:"Les chasseurs arrivent, gare à vos fesses !",become_seeker:"Tu peux chasser de la volaille à votre tour !"}}}

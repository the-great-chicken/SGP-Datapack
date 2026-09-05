#> sgp.majeurs:initialization


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



# ---------- Initialize Event-owned State ----------
function #sgp.majeurs:events/initialization

# ---------- Initialize Storages ----------

data modify storage sgp:data majeurs merge value {pco:{event:"pco",text:"Poule Canard Oie"},protect:{event:"protect",text:"Protéger le Roi"},hide_and_seek:{event:"hide_and_seek",text:"Cache-cache",end:{seeker:"Que la chasse à la volaille commence !",hider:"Les chasseurs arrivent, gare à vos fesses !",become_seeker:"Tu peux chasser de la volaille à votre tour !"}}}

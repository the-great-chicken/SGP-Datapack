#> sgp.lore:_discord_message
# 
# Stuns the players and tells them there is a new discord announcement

title @a subtitle {"text":"Message des organisateurs", "color":"yellow"}
title @a title {"text":"RDV dans #annonces ", "color":"gold"}
tellraw @a {"text":"Allez voir dans le salon #annonces du serveur Discord !", "color":"blue", "bold":true}
function sgp.lore:_stun_all_players {s:20}
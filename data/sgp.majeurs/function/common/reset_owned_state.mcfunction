#> sgp.majeurs:common/reset_owned_state
#
# Clear the event-specific state owned by the caller's retained major event.
# The owner tags survive logout, unlike the stop-time @a cleanup they replace.

execute if entity @s[tag=sgp.major.hide_and_seek] \
    run function sgp.majeurs:hide_and_seek/reset_player
execute if entity @s[tag=sgp.major.protect] \
    run function sgp.majeurs:protect/reset_player_state
execute if entity @s[tag=sgp.major.pco] \
    run function sgp.majeurs:pco/reset_player_state

tag @s remove sgp.major.hide_and_seek
tag @s remove sgp.major.protect
tag @s remove sgp.major.pco

#> sgp.misc:players_in_game/macro
# `{uuid: pvp_arena marker uuid}`

$execute as $(uuid) at @s \
        run function sgp.misc:players_in_game/check with entity @s data
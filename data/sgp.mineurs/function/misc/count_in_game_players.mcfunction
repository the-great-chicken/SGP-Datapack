#> sgp.mineurs:misc/count_in_game_players
#
# Count current in-game players into the scratch score, overwriting any stale value.

scoreboard players set #nbr_de_joueurs sgp.dummy 0
execute as @a[tag=sgp.in_game] run scoreboard players add #nbr_de_joueurs sgp.dummy 1

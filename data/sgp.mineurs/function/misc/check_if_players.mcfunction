#> sgp.mineurs:misc/check_if_players
#
# Disable minor events when fewer than two players are in the arena.

function sgp.mineurs:misc/count_in_game_players
execute if score #nbr_de_joueurs sgp.dummy matches ..1 run tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Il n'y a pas suffisamment de personnes dans l'arène...", color:dark_red}]
execute if score #nbr_de_joueurs sgp.dummy matches ..1 run function sgp.mineurs:_stop
scoreboard players set #nbr_de_joueurs sgp.dummy 0

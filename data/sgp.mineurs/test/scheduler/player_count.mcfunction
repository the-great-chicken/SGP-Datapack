#> sgp.mineurs:scheduler/player_count
# @dummy
# @environment sgp.ci:minor_scheduler/player_count
#
# Player counting must overwrite stale scratch state and report the exact number of in-game players.

# One player: a stale value must not survive the count.
tag @s add sgp.in_game
scoreboard players set #nbr_de_joueurs sgp.dummy 99
function sgp.mineurs:misc/count_in_game_players
assert score #nbr_de_joueurs sgp.dummy matches 1

# Two players: count both exactly.
dummy MinorSchedPeer spawn
tag MinorSchedPeer add sgp.in_game
scoreboard players set #nbr_de_joueurs sgp.dummy 99
function sgp.mineurs:misc/count_in_game_players
assert score #nbr_de_joueurs sgp.dummy matches 2

# The scheduler wrapper must use that fresh count and leave an active scheduler running with two players.
scoreboard players set #events_mineurs_actifs sgp.dummy 1
scoreboard players set #nbr_de_joueurs sgp.dummy 99
function sgp.mineurs:misc/check_if_players
assert score #events_mineurs_actifs sgp.dummy matches 1
assert score #nbr_de_joueurs sgp.dummy matches 0

dummy MinorSchedPeer leave

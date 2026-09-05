#> sgp.misc:selected_player/main
#`{div: int, add:int, tag: str, sign: /|%|-}`
#
# Select a random subset of non-peaceful in-game players and add the given tag
# to them. The number of selected players is computed from the number of
# eligible players using the provided division operator and divisor.

execute store result score #nbr_joueurs sgp.dummy if entity @a[tag=sgp.in_game,tag=!sgp.peaceful]
$scoreboard players set #div sgp.dummy $(div)
$scoreboard players set #add sgp.dummy $(add)

$scoreboard players operation #nbr_joueurs sgp.dummy $(sign)= #div sgp.dummy
scoreboard players operation #nbr_joueurs sgp.dummy += #add sgp.dummy

# A group too small to contribute a player must not produce an invalid selector limit.
execute if score #nbr_joueurs sgp.dummy matches ..0 run return 0

execute store result storage sgp:data misc.selected_player.nbr int 1 run scoreboard players get #nbr_joueurs sgp.dummy
$data modify storage sgp:data misc.selected_player.tag set value "$(tag)"

function sgp.misc:selected_player/macros_tag with storage sgp:data misc.selected_player

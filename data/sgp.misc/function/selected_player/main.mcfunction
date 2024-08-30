execute store result score #nbr_joueurs sgp.dummy if entity @a[tag=sgp.in_game]
$scoreboard players set #div sgp.dummy $(div)
$execute store result storage sgp:data misc.selected_player.nbr int 1 run scoreboard players operation #nbr_joueurs sgp.dummy $(sign)= #div sgp.dummy
$data modify storage sgp:data misc.selected_player.tag set value "$(tag)"
function sgp.misc:selected_player/macros_tag with storage sgp:data misc.selected_player
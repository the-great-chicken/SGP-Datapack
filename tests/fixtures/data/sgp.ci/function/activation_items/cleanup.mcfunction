#> sgp.ci:activation_items/cleanup
# Remove activation-item drops and markers, then disconnect every test player.

kill @e[tag=sgp.ci.activation_item,type=item]
kill @e[tag=sgp.ci.activation_marker,type=marker]
function sgp.ci:players/cleanup

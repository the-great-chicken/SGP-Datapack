#> sgp.misc:interactions/tp_to_spawn
# `{[x, y, z, yaw, pitch]: coordinates, article:"à la"|"au"|"aux", title: text component}`

$tp @s $(x) $(y) $(z) $(yaw) $(pitch)
$tellraw @s ["Tu as spawn $(article) ", $(title)]
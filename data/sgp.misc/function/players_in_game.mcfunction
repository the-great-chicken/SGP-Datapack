#> sgp.misc:players_in_game
# `{radius: int}`
#
# Players who are inside the radius have a tag, others don't

$execute as @a[distance=..$(radius),tag=!sgp.in_game] run tag @s sgp.add in_game
$execute as @a[distance=$(radius)..,tag=sgp.in_game] run tag @s remove sgp.in_game
#> sgp.misc:players_in_game/check
# `{radius: int}`
#
# Players within the inclusive radius in the arena's dimension are in-game.

$tag @a[distance=..$(radius)] add sgp.inside_arena
execute as @a[tag=sgp.in_game,tag=!sgp.inside_arena] run function sgp.misc:players_in_game/leave
tag @a[tag=sgp.inside_arena,tag=!sgp.in_game] add sgp.in_game
tag @a[tag=sgp.inside_arena] remove sgp.inside_arena

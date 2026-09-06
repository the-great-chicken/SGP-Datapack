#> sgp.misc:players_in_game/dimension
# @dummy
#
# Matching coordinates in a different dimension do not keep a player in the arena.

tag @s add sgp.in_game
experience set @s 5 levels
experience set @s 3 points
execute in minecraft:the_nether positioned as @s run function sgp.misc:players_in_game/check {radius:4}
execute store success storage sgp:data tests.arena_dimension.inside byte 1 if entity @s[tag=sgp.in_game]
execute store result storage sgp:data tests.arena_dimension.levels int 1 run experience query @s levels
execute store result storage sgp:data tests.arena_dimension.points int 1 run experience query @s points
tag @s remove sgp.in_game

assert data storage sgp:data tests.arena_dimension{inside:0b,levels:0,points:0}
data remove storage sgp:data tests.arena_dimension

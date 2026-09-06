#> sgp.misc:players_in_game/boundary
# @dummy
#
# The radius is inclusive and spherical, with no repeated entry/exit at its exact boundary.

summon marker ~0.5 ~1 ~0.5 {UUID:[I;121,0,0,1],Tags:["sgp.test.arena_boundary"],data:{radius:4}}
tag @s remove sgp.in_game
experience set @s 8 levels
experience set @s 6 points
tp @s ~4.5 ~1 ~0.5
function sgp.misc:players_in_game/macro {uuid:"00000079-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_boundary.entered byte 1 if entity @s[tag=sgp.in_game]
function sgp.misc:players_in_game/macro {uuid:"00000079-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_boundary.remained byte 1 if entity @s[tag=sgp.in_game]
execute store result storage sgp:data tests.arena_boundary.levels int 1 run experience query @s levels
execute store result storage sgp:data tests.arena_boundary.points int 1 run experience query @s points

tp @s ~4.51 ~1 ~0.5
function sgp.misc:players_in_game/macro {uuid:"00000079-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_boundary.beyond byte 1 if entity @s[tag=sgp.in_game]
tp @s ~4.49 ~1 ~0.5
function sgp.misc:players_in_game/macro {uuid:"00000079-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_boundary.within byte 1 if entity @s[tag=sgp.in_game]

tp @s ~0.5 ~5 ~0.5
function sgp.misc:players_in_game/macro {uuid:"00000079-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_boundary.vertical_edge byte 1 if entity @s[tag=sgp.in_game]
tp @s ~3.5 ~1 ~3.5
function sgp.misc:players_in_game/macro {uuid:"00000079-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_boundary.diagonal_outside byte 1 if entity @s[tag=sgp.in_game]
kill @e[tag=sgp.test.arena_boundary,distance=..8,type=marker]
tp @s ~0.5 ~1 ~0.5
tag @s remove sgp.in_game

assert data storage sgp:data tests.arena_boundary{entered:1b,remained:1b,levels:8,points:6,beyond:0b,within:1b,vertical_edge:1b,diagonal_outside:0b}
data remove storage sgp:data tests.arena_boundary

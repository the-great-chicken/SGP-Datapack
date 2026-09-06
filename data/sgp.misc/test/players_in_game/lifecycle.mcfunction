#> sgp.misc:players_in_game/lifecycle
# @dummy
#
# Entry preserves XP; departure clears it once; re-entry preserves newly earned XP.

summon marker ~0.5 ~1 ~0.5 {UUID:[I;120,0,0,1],Tags:["sgp.test.arena_lifecycle"],data:{radius:4}}
tag @s remove sgp.in_game
experience set @s 10 levels
experience set @s 7 points
tp @s ~1.5 ~1 ~0.5
function sgp.misc:players_in_game/macro {uuid:"00000078-0000-0000-0000-000000000001"}
function sgp.misc:players_in_game/macro {uuid:"00000078-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_lifecycle.entered byte 1 if entity @s[tag=sgp.in_game]
execute store result storage sgp:data tests.arena_lifecycle.entry_levels int 1 run experience query @s levels
execute store result storage sgp:data tests.arena_lifecycle.entry_points int 1 run experience query @s points

tp @s ~6.5 ~1 ~0.5
function sgp.misc:players_in_game/macro {uuid:"00000078-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_lifecycle.still_inside byte 1 if entity @s[tag=sgp.in_game]
execute store result storage sgp:data tests.arena_lifecycle.exit_levels int 1 run experience query @s levels
execute store result storage sgp:data tests.arena_lifecycle.exit_points int 1 run experience query @s points

experience set @s 3 levels
experience set @s 5 points
function sgp.misc:players_in_game/macro {uuid:"00000078-0000-0000-0000-000000000001"}
execute store result storage sgp:data tests.arena_lifecycle.outside_levels int 1 run experience query @s levels
execute store result storage sgp:data tests.arena_lifecycle.outside_points int 1 run experience query @s points
tp @s ~0.5 ~1 ~0.5
function sgp.misc:players_in_game/macro {uuid:"00000078-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_lifecycle.reentered byte 1 if entity @s[tag=sgp.in_game]
execute store result storage sgp:data tests.arena_lifecycle.reentry_levels int 1 run experience query @s levels
execute store result storage sgp:data tests.arena_lifecycle.reentry_points int 1 run experience query @s points
kill @e[tag=sgp.test.arena_lifecycle,distance=..8,type=marker]
tag @s remove sgp.in_game

assert data storage sgp:data tests.arena_lifecycle{entered:1b,entry_levels:10,entry_points:7,still_inside:0b,exit_levels:0,exit_points:0,outside_levels:3,outside_points:5,reentered:1b,reentry_levels:3,reentry_points:5}
data remove storage sgp:data tests.arena_lifecycle

#> sgp.misc:players_in_game/player_isolation
# @dummy
#
# One player's departure clears only their own membership and XP, while another remains in the arena.

summon marker ~0.5 ~1 ~0.5 {UUID:[I;122,0,0,1],Tags:["sgp.test.arena_players"],data:{radius:4}}
dummy ArenaOther spawn
tag @s remove sgp.in_game
tag ArenaOther remove sgp.in_game
tp @s ~0.5 ~1 ~0.5
tp ArenaOther ~1.5 ~1 ~0.5
experience set @s 9 levels
experience set @s 4 points
experience set ArenaOther 12 levels
experience set ArenaOther 8 points
function sgp.misc:players_in_game/macro {uuid:"0000007a-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_players.first_entered byte 1 if entity @s[tag=sgp.in_game]
execute store success storage sgp:data tests.arena_players.other_entered byte 1 if entity @a[name=ArenaOther,tag=sgp.in_game]

tp @s ~6.5 ~1 ~0.5
function sgp.misc:players_in_game/macro {uuid:"0000007a-0000-0000-0000-000000000001"}
execute store success storage sgp:data tests.arena_players.first_remained byte 1 if entity @s[tag=sgp.in_game]
execute store success storage sgp:data tests.arena_players.other_remained byte 1 if entity @a[name=ArenaOther,tag=sgp.in_game]
execute store result storage sgp:data tests.arena_players.first_levels int 1 run experience query @s levels
execute store result storage sgp:data tests.arena_players.first_points int 1 run experience query @s points
execute store result storage sgp:data tests.arena_players.other_levels int 1 run experience query ArenaOther levels
execute store result storage sgp:data tests.arena_players.other_points int 1 run experience query ArenaOther points
dummy ArenaOther leave
kill @e[tag=sgp.test.arena_players,distance=..8,type=marker]
tp @s ~0.5 ~1 ~0.5

assert data storage sgp:data tests.arena_players{first_entered:1b,other_entered:1b,first_remained:0b,other_remained:1b,first_levels:0,first_points:0,other_levels:12,other_points:8}
data remove storage sgp:data tests.arena_players

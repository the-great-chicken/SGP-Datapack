#> sgp.mineurs:magic/eligibility
# @dummy
#
# A real random event affects active combatants and excludes peaceful players and outsiders.

data modify storage sgp:data tests.magic_players set value {}
tag @s add sgp.in_game
dummy MagicPeaceful spawn
tag MagicPeaceful add sgp.in_game
tag MagicPeaceful add sgp.peaceful
dummy MagicOutside spawn
function sgp.mineurs:magic/start
execute store success storage sgp:data tests.magic_players.active byte 1 run effect clear @s
execute store success storage sgp:data tests.magic_players.peaceful byte 1 run effect clear MagicPeaceful
execute store success storage sgp:data tests.magic_players.outside byte 1 run effect clear MagicOutside
dummy MagicPeaceful leave
dummy MagicOutside leave

assert data storage sgp:data tests.magic_players{active:1b,peaceful:0b,outside:0b}
data remove storage sgp:data tests.magic_players

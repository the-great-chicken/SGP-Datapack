#> sgp.misc:spawn_routing/protect_teams
# @dummy
# @environment sgp.ci:spawn_routing
#
# Protect routes each team to its own spawn only once combat is active; selection must not fall through to a normal spawn.

function sgp.ci:spawn_routing/fixture
team join sgp.rouge @s
tag @s add sgp.major_participant
scoreboard players set #protect_phase sgp.dummy 1
function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing first
execute positioned ~0.5 ~1 ~0.5 run assert entity @s[distance=..0.01]
scoreboard players set #protect_phase sgp.dummy 2
function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing first
execute positioned ~20.5 ~1 ~0.5 run assert entity @s[distance=..0.01]
team join sgp.bleue @s
function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing first
execute positioned ~22.5 ~1 ~0.5 run assert entity @s[distance=..0.01]
assert entity @s[team=sgp.bleue,tag=sgp.major_participant]

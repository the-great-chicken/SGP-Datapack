#> sgp.misc:spawn_routing/confinement_priority
# @dummy
# @environment sgp.ci:spawn_routing
#
# Confinement overrides normal and major-event spawns, and its expiry restores the appropriate route.

function sgp.ci:spawn_routing/fixture
scoreboard players set #confines_secondes sgp.timer 1
function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing first
execute positioned ~16.5 ~1 ~0.5 run assert entity @s[distance=..0.01]
team join sgp.rouge @s
scoreboard players set #protect_phase sgp.dummy 2
tp @s ~0.5 ~1 ~0.5
function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing first
execute positioned ~16.5 ~1 ~0.5 run assert entity @s[distance=..0.01]
scoreboard players set #confines_secondes sgp.timer 0
function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing first
execute positioned ~20.5 ~1 ~0.5 run assert entity @s[distance=..0.01]
team leave @s
function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing first
execute positioned ~4.25 ~1 ~0.75 run assert entity @s[distance=..0.01]

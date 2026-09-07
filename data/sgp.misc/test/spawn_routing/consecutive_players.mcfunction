#> sgp.misc:spawn_routing/consecutive_players
# @dummy
# @environment sgp.ci:spawn_routing
#
# A later request uses its own destination list and moves only its requesting player.

function sgp.ci:spawn_routing/fixture
dummy SpawnOther spawn
tag SpawnOther add sgp.ci.spawn_actor
gamemode creative SpawnOther
tp SpawnOther ~0.5 ~1 ~2.5
function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing first
execute as SpawnOther run function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing second
execute positioned ~4.25 ~1 ~0.75 run assert entity @s[distance=..0.01]
execute positioned ~8.75 ~1 ~0.25 run assert entity @a[name=SpawnOther,distance=..0.01]
function sgp.ci:spawn_routing/expect_facing {yaw:90,pitch:15}
execute as SpawnOther run function sgp.ci:spawn_routing/expect_facing {yaw:-90,pitch:-30}
function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing second
execute positioned ~8.75 ~1 ~0.25 run assert entity @s[distance=..0.01]

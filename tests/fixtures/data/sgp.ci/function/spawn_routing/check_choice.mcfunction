#> sgp.ci:spawn_routing/check_choice
# Every result must be a complete configured destination, including its facing. Do not require a particular random sequence.

function sgp.misc:interactions/go_to_choose_spawn with storage sgp.ci:spawn_routing normal
execute at @s run assert entity @e[tag=sgp.ci.spawn_destination,distance=..0.01,type=marker]
execute positioned ~4.25 ~1 ~0.75 if entity @s[distance=..0.01] run function sgp.ci:spawn_routing/expect_facing {yaw:90,pitch:15}
execute positioned ~8.75 ~1 ~0.25 if entity @s[distance=..0.01] run function sgp.ci:spawn_routing/expect_facing {yaw:-90,pitch:-30}
scoreboard players remove #ci.spawn.samples sgp.dummy 1
execute if score #ci.spawn.samples sgp.dummy matches 1.. run function sgp.ci:spawn_routing/check_choice

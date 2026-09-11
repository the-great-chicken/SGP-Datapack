#> sgp.kits:ability_entrypoints/cleave
# @dummy
# @environment sgp.ci:ability_entrypoints/cleave
#
# Combattant routing must create exactly one initialized sweep display using the first animation frame.

function sgp.ci:ability_entrypoints/seed_stats {id:920003,kit:1,ability:"cleave"}
tag @s add sgp.combattant

execute at @s run function sgp.kits:abilities/route_ability

# Claim the production artifact immediately; all later cleanup is test-owned.
tag @e[tag=sgp.giant_sweep,distance=..5,type=item_display] add sgp.ci.ability_entrypoint
function sgp.ci:ability_entrypoints/expect_cooldown {ability:"cleave"}
execute store result score #ci.ability.count sgp.dummy if entity @e[tag=sgp.ci.ability_entrypoint,tag=sgp.giant_sweep,distance=..5,type=item_display]
assert score #ci.ability.count sgp.dummy matches 1
assert not entity @e[tag=sgp.ci.ability_entrypoint,tag=sgp.giant_sweep_new,type=item_display]
assert score @e[tag=sgp.ci.ability_entrypoint,tag=sgp.giant_sweep,limit=1,type=item_display] sgp.timer matches 0
execute store success score #ci.ability.frame sgp.dummy if items entity @e[tag=sgp.ci.ability_entrypoint,tag=sgp.giant_sweep,limit=1,type=item_display] container.0 minecraft:paper[minecraft:item_model="sgp.kits:giant_sweep_0"]
assert score #ci.ability.frame sgp.dummy matches 1

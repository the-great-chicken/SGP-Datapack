#> sgp.kits:ability_entrypoints/rays
# @dummy
# @environment sgp.ci:ability_entrypoints/rays
#
# Roi routing must create all eight linked beam children and initialize the configured caster timers.

function sgp.ci:ability_entrypoints/seed_stats {id:920004,kit:6,ability:"rays"}
tag @s add sgp.roi
function #bs.id:give_suid

execute at @s run function sgp.kits:abilities/route_ability

# The beam entities stay at the caster; claim only this activation's local set.
tag @e[tag=sgp.ray,distance=..3,type=item_display] add sgp.ci.ability_entrypoint
function sgp.ci:ability_entrypoints/expect_timers {ability:"rays"}
execute store result score #ci.ability.count sgp.dummy if entity @e[tag=sgp.ci.ability_entrypoint,tag=sgp.ray,distance=..3,type=item_display]
assert score #ci.ability.count sgp.dummy matches 8
scoreboard players operation $link.to bs.in = @s bs.id
execute store result score #ci.ability.linked sgp.dummy if entity @e[tag=sgp.ci.ability_entrypoint,tag=sgp.ray,predicate=bs.link:link_equal,distance=..3,type=item_display]
assert score #ci.ability.linked sgp.dummy matches 8
execute store result score #ci.ability.timed sgp.dummy if entity @e[tag=sgp.ci.ability_entrypoint,tag=sgp.ray,scores={sgp.timer=70},distance=..3,type=item_display]
assert score #ci.ability.timed sgp.dummy matches 8

function sgp.kits:abilities/rays/end
assert not entity @e[tag=sgp.ci.ability_entrypoint,tag=sgp.ray,type=item_display]

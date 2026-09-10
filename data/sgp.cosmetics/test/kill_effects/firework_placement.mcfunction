#> sgp.cosmetics:kill_effects/firework_placement
# @dummy
# @environment sgp.ci:kill_effects/firework_placement
#
# The firework effect produces five rockets around the victim, not the attacker.

function sgp.ci:kill_effects/roster
await delay 61t
function sgp.ci:kill_effects/prepare
tag @s add sgp.kill.firework
function sgp.ci:kill_effects/record_attacker
function sgp.ci:kill_effects/dispatch
execute store result score #ci.effects.count sgp.dummy if entity @e[tag=sgp.ci.kill_effect,type=firework_rocket]
assert score #ci.effects.count sgp.dummy matches 5
execute positioned ~5.5 ~2 ~5.5 store result score #ci.effects.near sgp.dummy if entity @e[tag=sgp.ci.kill_effect,distance=..0.31,type=firework_rocket]
assert score #ci.effects.near sgp.dummy matches 5
assert not entity @e[tag=sgp.ci.kill_effect,type=falling_block]

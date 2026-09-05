#> sgp.mineurs:reflexes/deadline_and_eligibility
# @dummy
#
# Responders are spared; only unanswered participants receive TNT when the five-second deadline is reached.

data modify storage sgp:data tests.reflexes_deadline set value {}
tag @s add sgp.in_game
tp @s ~0.5 ~1 ~0.5
dummy ReflexUnanswered spawn
tag ReflexUnanswered add sgp.in_game
tp ReflexUnanswered ~4.5 ~1 ~0.5
dummy ReflexOutside spawn
tp ReflexOutside ~8.5 ~1 ~0.5
function sgp.mineurs:reflexes/start
trigger sgp.reflexes_joueur
function sgp.ci:minor_events/advance {function:"sgp.mineurs:reflexes/running",ticks:98}
execute store result storage sgp:data tests.reflexes_deadline.before int 1 if entity @e[distance=..12,type=tnt]
function sgp.mineurs:reflexes/running
execute positioned ~0.5 ~1 ~0.5 store result storage sgp:data tests.reflexes_deadline.responded int 1 if entity @e[distance=..0.1,type=tnt]
execute positioned ~4.5 ~1 ~0.5 store result storage sgp:data tests.reflexes_deadline.unanswered int 1 if entity @e[distance=..0.1,type=tnt]
execute positioned ~8.5 ~1 ~0.5 store result storage sgp:data tests.reflexes_deadline.outside int 1 if entity @e[distance=..0.1,type=tnt]
kill @e[distance=..12,type=tnt]
dummy ReflexUnanswered leave
dummy ReflexOutside leave

assert data storage sgp:data tests.reflexes_deadline{before:0,responded:0,unanswered:1,outside:0}
assert not entity @s[tag=sgp.reflexes_check]
data remove storage sgp:data tests.reflexes_deadline

#> sgp.ci:kill_effects/expect_none
# Require the death hook to spawn no observable kill-effect entities.

assert not entity @e[tag=sgp.ci.kill_effect,type=falling_block]
assert not entity @e[tag=sgp.ci.kill_effect,type=firework_rocket]

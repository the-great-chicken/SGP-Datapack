#> sgp.ci:kill_effects/expect_anvil

execute store result score #ci.effects.count sgp.dummy if entity @e[tag=sgp.ci.kill_effect,type=falling_block]
assert score #ci.effects.count sgp.dummy matches 1
execute positioned ~5.5 ~1 ~5.5 run assert entity @e[tag=sgp.ci.kill_effect,distance=..0.01,type=falling_block]
assert not entity @e[tag=sgp.ci.kill_effect,type=firework_rocket]

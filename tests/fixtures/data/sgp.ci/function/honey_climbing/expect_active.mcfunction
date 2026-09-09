#> sgp.ci:honey_climbing/expect_active
assert entity @s[tag=sgp.sliding_up]
function sgp.ci:honey_climbing/expect_gravity {range:"-1201..-1199"}
assert not entity @e[tag=sgp.vel_reset,distance=..8,type=armor_stand]

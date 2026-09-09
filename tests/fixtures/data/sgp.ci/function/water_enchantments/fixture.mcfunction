#> sgp.ci:water_enchantments/fixture

fill ~ ~ ~ ~12 ~ ~8 stone
fill ~ ~1 ~ ~12 ~5 ~8 air
# A contained, one-block-deep pool permits wading without swimming or drowning.
fill ~2 ~1 ~2 ~6 ~1 ~6 stone
fill ~3 ~1 ~3 ~5 ~1 ~5 water
gamemode survival @s
attribute @s minecraft:movement_speed base set 0.1
attribute @s minecraft:water_movement_efficiency base set 0
tp @s ~9.5 ~1 ~4.5

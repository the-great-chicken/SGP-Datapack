#> sgp.ci:honey_climbing/fixture
# Build a clear survival arena with vanilla gravity as the honey-climbing baseline.

fill ~ ~1 ~ ~6 ~5 ~6 air
fill ~ ~ ~ ~6 ~ ~6 stone
gamemode survival @s
attribute @s minecraft:gravity base set 0.08

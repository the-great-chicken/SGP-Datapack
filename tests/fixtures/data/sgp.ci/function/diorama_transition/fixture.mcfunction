#> sgp.ci:diorama_transition/fixture
# Build a clear arena and assign the transitioning player the fixture identity expected by the animation.

fill ~ ~1 ~ ~10 ~6 ~10 air
fill ~ ~ ~ ~10 ~ ~10 stone
gamemode survival @s
tp @s ~1.5 ~1 ~1.5 0 0
scoreboard players set @s sgp.id 92001

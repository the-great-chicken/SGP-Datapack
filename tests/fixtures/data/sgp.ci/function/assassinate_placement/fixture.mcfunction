#> sgp.ci:assassinate_placement/fixture
# An assassin and a separate target on a flat platform.

execute as @a[tag=sgp.ci.assassin_actor] run dummy @s leave
function sgp.ci:assassinate_placement/clear_projectiles
fill ~ ~1 ~ ~16 ~6 ~16 air
fill ~ ~ ~ ~16 ~ ~16 stone
tag @s add sgp.ci.assassin_actor
tag @s add sgp.assassin_triggered
gamemode creative @s
tp @s ~2.5 ~1 ~8.5
dummy AssTarget spawn
tag AssTarget add sgp.ci.assassin_actor
gamemode creative AssTarget
tp AssTarget ~8.5 ~1 ~8.5 0 0

#> sgp.ci:fangs_placement/fixture
# A platform with enough room above and below it for terrain changes.

execute as @a[tag=sgp.ci.fangs_actor] run dummy @s leave
kill @e[tag=sgp.ci.fang,type=evoker_fangs]
fill ~ ~ ~ ~12 ~7 ~12 air
fill ~ ~2 ~ ~12 ~2 ~12 stone
tag @s add sgp.ci.fangs_actor
gamemode creative @s
tp @s ~10.5 ~3 ~10.5

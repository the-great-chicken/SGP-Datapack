#> sgp.ci:illusions_movement/fixture

execute as @a[tag=sgp.ci.illusion_actor] run dummy @s leave
function sgp.ci:illusions_movement/clear
fill ~ ~1 ~ ~15 ~7 ~15 air
fill ~ ~ ~ ~15 ~ ~15 stone
tag @s add sgp.ci.illusion_actor
gamemode survival @s
tp @s ~8.5 ~1 ~8.5 0 0
execute at @s run function sgp.ci:illusions_movement/formation {group:first}

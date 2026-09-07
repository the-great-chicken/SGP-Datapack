#> sgp.ci:illusions_movement/fixture

execute as @a[tag=sgp.ci.illusion_actor] run dummy @s leave
function sgp.ci:illusions_movement/clear
fill ~ ~1 ~ ~32 ~7 ~16 air
fill ~ ~ ~ ~32 ~ ~16 stone
tag @s add sgp.ci.illusion_actor
gamemode creative @s
tp @s ~8.5 ~1 ~8.5 0 0
execute at @s run function sgp.ci:illusions_movement/formation {group:first}

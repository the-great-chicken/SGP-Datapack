#> sgp.ci:bats_equipment/fixture

execute as @a[tag=sgp.ci.bats_actor] run dummy @s leave
tag @s add sgp.ci.bats_actor
gamemode creative @s
fill ~ ~1 ~ ~4 ~4 ~4 air
fill ~ ~ ~ ~4 ~ ~4 stone
tp @s ~0.5 ~1 ~0.5
function sgp.ci:bats_equipment/equip

#> sgp.ci:pyromane_fire/fixture
# Reset fire fixtures and build the clear arena used for lingering-fire behavior.

execute as @a[tag=sgp.ci.fire_actor] run dummy @s leave
kill @e[tag=sgp.ci.fire,type=marker]
kill @e[tag=sgp.ci.fire,type=tnt]
kill @e[tag=sgp.ci.fire,type=interaction]
fill ~ ~1 ~ ~20 ~5 ~12 air
fill ~ ~ ~ ~20 ~ ~12 stone
tag @s add sgp.ci.fire_actor
gamemode creative @s
tp @s ~18.5 ~1 ~10.5

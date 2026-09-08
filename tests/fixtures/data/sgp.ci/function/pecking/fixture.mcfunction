#> sgp.ci:pecking/fixture
# An active attack facing one opponent. Stats collection is outside this fixture.

execute as @a[tag=sgp.ci.peck_actor] run dummy @s leave
fill ~ ~1 ~ ~12 ~5 ~12 air
fill ~ ~ ~ ~12 ~ ~12 stone
tag @s add sgp.ci.peck_actor
tag @s add sgp.pigeon
tag @s add sgp.is_pecking
gamemode survival @s
tp @s ~4.5 ~1 ~4.5 0 0
scoreboard players set @s sgp.duration_ability 100
scoreboard players set @s sgp.cooldown_ability 0
scoreboard players set @s sgp.pecking_timer 0
dummy PeckNear spawn
tag PeckNear add sgp.ci.peck_actor
gamemode survival PeckNear
tp PeckNear ~4.5 ~1 ~6.5 0 0

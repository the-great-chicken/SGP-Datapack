#> sgp.ci:rays/fixture
# Build the absolute Rays arena, create a survival caster identity, and seed the ability duration.

fill -12 87 -12 28 87 28 stone
fill -12 88 -12 28 92 28 air
gamemode survival @s
tp @s 8.5 88.0 8.5 0 0
function #bs.id:give_suid
scoreboard players set @s sgp.duration_ability 70

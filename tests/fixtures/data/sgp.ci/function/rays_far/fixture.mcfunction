#> sgp.ci:rays_far/fixture
# Build a Rays arena far from the world origin, create a survival caster identity, and seed the ability duration.

fill 988 87 988 1028 87 1028 stone
fill 988 88 988 1028 92 1028 air
gamemode survival @s
tp @s 1008.5 88.0 1008.5 0 0
function #bs.id:give_suid
scoreboard players set @s sgp.duration_ability 70

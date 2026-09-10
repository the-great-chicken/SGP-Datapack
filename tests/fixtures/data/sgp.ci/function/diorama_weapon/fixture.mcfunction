#> sgp.ci:diorama_weapon/fixture
# Create a clean survival player with an empty inventory and deterministic selected slot.

fill ~ ~1 ~ ~10 ~5 ~10 air
fill ~ ~ ~ ~10 ~ ~10 stone
gamemode survival @s
tp @s ~1.5 ~1 ~1.5 0 0
clear @s
dummy @s selectslot 1

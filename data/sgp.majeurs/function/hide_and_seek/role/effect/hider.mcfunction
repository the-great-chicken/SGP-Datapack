#> sgp.majeurs:hide_and_seek/role/effect/hider
#
# give effect to the hider

effect clear @s invisibility
effect clear @s speed
effect clear @s resistance
effect clear @s jump_boost

effect give @s speed infinite 0 true
effect give @s jump_boost infinite 0 true

function sgp.majeurs:hide_and_seek/teams/apply_lost_effects
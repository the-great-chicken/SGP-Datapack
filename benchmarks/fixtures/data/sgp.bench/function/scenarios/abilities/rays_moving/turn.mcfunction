#> sgp.bench:scenarios/abilities/rays_moving/turn
# Executed as one actor during setup: turn 9 degrees per remaining count.
execute if score #rays_moving_turns sgp.bench matches ..0 run return 0
execute at @s run rotate @s ~9 ~
scoreboard players remove #rays_moving_turns sgp.bench 1
function sgp.bench:scenarios/abilities/rays_moving/turn

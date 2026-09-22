#> sgp.bench:scenarios/abilities/rays_moving/face
# `{first: int}`
# Executed as one actor: yaw = 9 degrees * actor index, applied as relative turns.
scoreboard players operation #rays_moving_turns sgp.bench = @s sgp.bench
$scoreboard players remove #rays_moving_turns sgp.bench $(first)
function sgp.bench:scenarios/abilities/rays_moving/turn

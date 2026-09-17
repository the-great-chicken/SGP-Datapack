
#> sgp.bench:scenarios/abilities/rays_dense/position
# `{first: int}`
# Executed as one actor. Put the component on a deterministic 0.75-block-spaced
# east/west line so each cardinal ray can pierce many real player targets.

$scoreboard players operation @s sgp.bench.clock = @s sgp.bench
$scoreboard players remove @s sgp.bench.clock $(first)
scoreboard players operation @s bs.pos.x = @s sgp.bench.clock
scoreboard players set #ray_dense_spacing sgp.bench 750
scoreboard players operation @s bs.pos.x *= #ray_dense_spacing sgp.bench
scoreboard players add @s bs.pos.x -15000
scoreboard players set @s bs.pos.y 81000
scoreboard players set @s bs.pos.z -30000
function #bs.position:set_pos {scale:0.001}
tp @s ~ ~ ~ -90 0

#> sgp.ci:rays/update
# Run one production Rays tick and verify transient state is fully consumed.

# Production sweeps the transient hitbox cache every tick (abilities/tick). Fake players keep scoreboard
# scores but lose tags across reconnects, so reset both here or the fast entity path is never exercised.
scoreboard players reset @a[tag=!bs.hitbox.custom,tag=!bs.hitbox.baked,tag=!bs.hitbox.centered] bs.width
scoreboard players reset @a[tag=!bs.hitbox.custom,tag=!bs.hitbox.baked,tag=!bs.hitbox.centered] bs.height
scoreboard players reset @a[tag=!bs.hitbox.custom,tag=!bs.hitbox.baked,tag=!bs.hitbox.centered] bs.depth
tag @a remove sgp.ray_hitbox_cached
execute at @s run function sgp.kits:abilities/rays/tick
assert not entity @s[tag=sgp.radiator]
assert not entity @a[tag=sgp.ray_target]
execute positioned 8.0 88.0 8.0 run assert not entity @e[tag=sgp.predictor,distance=..64,type=marker]

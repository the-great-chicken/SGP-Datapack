#> sgp.ci:rays/update
# Run one production Rays tick and verify transient radiator/predictor state is fully consumed.

execute at @s run function sgp.kits:abilities/rays/tick
assert not entity @s[tag=sgp.radiator]
execute positioned 8.0 88.0 8.0 run assert not entity @e[tag=sgp.predictor,distance=..64,type=marker]

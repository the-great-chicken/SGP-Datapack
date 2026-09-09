#> sgp.ci:rays/update

execute at @s run function sgp.kits:abilities/rays/tick
assert not entity @s[tag=sgp.radiator]
execute positioned 8.0 88.0 8.0 run assert not entity @e[tag=sgp.predictor,distance=..64,type=marker]

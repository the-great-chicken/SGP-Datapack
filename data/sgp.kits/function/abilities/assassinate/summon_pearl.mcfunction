#> sgp.kits:abilities/assassinate/summon_pearl

execute positioned ~ ~0.2 ~ summon ender_pearl run function sgp.kits:abilities/assassinate/setup_pearl
execute positioned ~ ~-0.3 ~ summon endermite run function sgp.kits:abilities/assassinate/setup_colliding_entity

rotate @p[tag=sgp.assassin_triggered,distance=0..] ~ ~
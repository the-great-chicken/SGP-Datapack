#> sgp.ci:tnt_detonation/expect_fire
# `{owner: player id, x: coordinate}`
#
# Require fresh fire at the selected charge position with the detonating projectile's owner identity.

$execute positioned $(x) ~1 ~0.5 run assert entity @e[tag=sgp.ci.detonation_fire,tag=sgp.fire_explosion,tag=!sgp.new,scores={sgp.damage_owner=$(owner),sgp.timer=100},distance=..0.01,type=marker]

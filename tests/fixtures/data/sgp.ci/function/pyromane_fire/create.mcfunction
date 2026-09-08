#> sgp.ci:pyromane_fire/create
# {owner, x}
# Turn a detonating projectile into its lingering fire.

$summon tnt $(x) ~1 ~0.5 {Tags:["sgp.ci.fire","sgp.tnt"],fuse:80s}
$execute positioned $(x) ~1 ~0.5 run scoreboard players set @n[tag=sgp.ci.fire,distance=..0.1,type=tnt] sgp.damage_owner $(owner)
$execute positioned $(x) ~1 ~0.5 as @n[tag=sgp.ci.fire,distance=..0.1,type=tnt] run function sgp.kits:abilities/tnt/summon_fire
$execute positioned $(x) ~1 ~0.5 run tag @e[tag=sgp.fire_explosion,distance=..0.1,type=marker] add sgp.ci.fire
kill @e[tag=sgp.ci.fire,type=tnt]

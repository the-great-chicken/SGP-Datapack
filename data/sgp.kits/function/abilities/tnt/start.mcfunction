#> sgp.kits:abilities/tnt/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.tnt.cooldown

summon tnt ~ ~0.5 ~ {fuse:40, explosion_power:2.5f, Tags:["sgp.tnt"]}

# Summon an interaction with a link to the TNT. We can't use Passengers as it would be sitting *above* the TNT.
summon interaction ~ ~0.5 ~ {width:1.1f, height:1.1f, Tags:["sgp.tnt_interaction", "sgp.new"]}
execute as @e[tag=sgp.new,distance=..1,limit=1,type=interaction] run function sgp.kits:abilities/tnt/setup_interaction

playsound entity.tnt.primed master @a[tag=sgp.in_game] ~ ~ ~ 1
schedule function sgp.kits:abilities/tnt/explode_at 40t append
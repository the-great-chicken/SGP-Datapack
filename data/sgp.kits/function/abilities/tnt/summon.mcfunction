scoreboard players set @s sgp.cooldown_ability 200

summon tnt ~ ~ ~ {fuse:40,explosion_power:3b}
playsound entity.tnt.primed master @a[tag=sgp.in_game] ~ ~ ~ 1
schedule function sgp.kits:abilities/tnt/explode 40t
scoreboard players set @s sgp.cooldown_ability 200

summon tnt ~ ~0.5 ~ {fuse:40, explosion_power:2.5f, Tags:["sgp.tnt"]}

# Summon an interaction with a link to the TNT. We can't use Passengers as it would be sitting *above* the TNT.
summon interaction ~ ~0.5 ~ {width:1f, height:1f, Tags:["sgp.tnt_interaction", "sgp.new"]}
execute as @e[type=interaction,tag=sgp.new] at @n[type=tnt,tag=sgp.tnt] run function #bs.link:create_link_ata
tag @e[type=interaction,tag=sgp.new] remove sgp.new

execute as @n[tag=sgp.tnt_interaction] run function #bs.interaction:on_left_click { run: "execute at @s run function sgp.kits:abilities/tnt/apply_kb", executor: source }
playsound entity.tnt.primed master @a[tag=sgp.in_game] ~ ~ ~ 1
schedule function sgp.kits:abilities/tnt/explode 40t append
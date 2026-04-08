scoreboard players set @s sgp.cooldown_ability 200

effect give @s invisibility 5 0 true
execute positioned ~ ~0.2 ~ as @e[limit=10] run summon bat ~ ~ ~ {Tags:["sgp.bat_grenade"]}
execute positioned ~ ~ ~ as @e[type=bat,tag=sgp.bat_grenade,sort=nearest,limit=10] run function #bs.health:time_to_live {with:{time:10,unit:"s"}}

tag @s add sgp.hidden_equipment
tag @s add sgp.processing

execute summon armor_stand run function sgp.kits:abilities/bats/hide_equipment

tag @s remove sgp.processing

schedule function sgp.kits:abilities/bats/restore_scheduled 100t
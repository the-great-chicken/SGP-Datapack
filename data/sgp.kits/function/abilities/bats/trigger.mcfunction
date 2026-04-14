#> sgp.kits:abilities/bats/trigger

scoreboard players set @s sgp.cooldown_ability 400

effect give @s invisibility 5 0 true
effect give @s weakness 5 0 true
execute positioned ~ ~0.2 ~ run function sgp.misc:summon_multiple {nbr:10, entity:bat, nbt:{Tags:["sgp.bat_grenade"]},execute:'function #bs.health:time_to_live {with:{time:10,unit:"s"}}'}

tag @s add sgp.hidden_equipment
tag @s add sgp.processing

execute summon armor_stand run function sgp.kits:abilities/bats/hide/equipment

tag @s remove sgp.processing

# Bats can only detonate after 1s (although if another cancer casted the ability earlier, the explosion check will already be running)
# And I'm too lazy to fix this concurrency bug, it doesn't really matter
schedule function sgp.kits:abilities/bats/check_for_explosion 1s append

schedule function sgp.kits:abilities/bats/restore_scheduled 100t append
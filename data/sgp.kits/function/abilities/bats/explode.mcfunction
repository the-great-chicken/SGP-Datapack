#> sgp.kits:abilities/bats/explode
#
# Executed as and at a grenade bat.

scoreboard players operation #damage_owner sgp.dummy = @s sgp.damage_owner
scoreboard players operation #exploding_bat_cast sgp.dummy = @s sgp.ability_cast

# A use succeeds on its first detonating bat. The cast comparison prevents a
# late bat from being attached to a newer activation by the same player.
execute as @a \
    if score @s sgp.id = #damage_owner sgp.dummy \
    if score @s sgp.ability_cast = #exploding_bat_cast sgp.dummy \
        run function sgp.kits:stats_collector/ability/mark_success {kit_id:10,ability_path:"bats"}

summon tnt ~ ~ ~ {explosion_power:1.3f,fuse:0s,Tags:["sgp.bat_grenade", "sgp.new"]}

execute as @a[gamemode=!creative] \
    if score @s sgp.id = #damage_owner sgp.dummy \
        run data modify entity @n[tag=sgp.new,distance=..1,limit=1,type=tnt] owner set from entity @s UUID

tag @e[tag=sgp.new,distance=..1,type=tnt] remove sgp.new

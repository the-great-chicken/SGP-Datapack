#> sgp.kits:abilities/bats/explode
#
# Executed as and at a grenade bat.

# Same-tick scheduled scans must not detonate one bat more than once.
execute if entity @s[tag=sgp.bat_detonated] run return 0
tag @s add sgp.bat_detonated

scoreboard players operation #damage_owner sgp.dummy = @s sgp.damage_owner
scoreboard players operation #exploding_bat_cast sgp.dummy = @s sgp.ability_cast

# Several bats from one cast can overlap the same target and would otherwise create nearly identical explosions in the same tick.
# Share this blast with same-cast bats whose centers are within one bat-width,
# but only when those bats independently satisfy the normal detonation condition at their position.
execute as @e[tag=sgp.bat_grenade,tag=!sgp.bat_detonated,distance=..0.5,type=bat] at @s \
    if score @s sgp.damage_owner = #damage_owner sgp.dummy \
    if score @s sgp.ability_cast = #exploding_bat_cast sgp.dummy \
    if function sgp.kits:abilities/bats/has_explosion_target \
        run tag @s add sgp.bat_detonated

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

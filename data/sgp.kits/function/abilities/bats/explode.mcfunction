#> sgp.kits:abilities/bats/explode
#
# Executed as and at a grenade bat.

scoreboard players operation #damage_owner sgp.dummy = @s sgp.damage_owner

execute as @a \
    if score @s sgp.id = #damage_owner sgp.dummy \
        run tag @s add sgp.current_damage_owner

summon tnt ~ ~ ~ {explosion_power:1.3f,fuse:0s,Tags:["sgp.bat_grenade", "sgp.new"]}

execute if entity @a[tag=sgp.current_damage_owner,limit=1,gamemode=!creative] \
    run data modify entity @n[tag=sgp.new,distance=..1,limit=1,type=tnt] owner \
        set from entity @a[tag=sgp.current_damage_owner,limit=1,gamemode=!creative] UUID

tag @e[tag=sgp.new,distance=..1,type=tnt] remove sgp.new
tag @s remove sgp.current_damage_owner

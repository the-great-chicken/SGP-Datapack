#> sgp.kits:abilities/tnt/damage_fire
# `{radius: double}`
#
# Executed as and at a lingering-fire marker.

scoreboard players operation #damage_owner sgp.dummy = @s sgp.damage_owner

execute as @a \
    if score @s sgp.id = #damage_owner sgp.dummy \
        run tag @s add sgp.current_damage_owner

# Attribute other players' damage to the caster. 
# Unowned behaviour for self-damage and for a caster who is no longer online.
$execute if entity @a[tag=sgp.current_damage_owner,limit=1] \
    as @a[tag=sgp.in_game,tag=!sgp.peaceful,tag=!sgp.current_damage_owner,distance=..$(radius)] \
        run damage @s 2 on_fire by @a[tag=sgp.current_damage_owner,limit=1]

$execute as @a[tag=sgp.in_game,tag=!sgp.peaceful,tag=sgp.current_damage_owner,distance=..$(radius)] \
    run damage @s 2 on_fire

$execute unless entity @a[tag=sgp.current_damage_owner,limit=1] \
    as @a[tag=sgp.in_game,tag=!sgp.peaceful,distance=..$(radius)] \
        run damage @s 2 on_fire

tag @a[tag=sgp.current_damage_owner] remove sgp.current_damage_owner

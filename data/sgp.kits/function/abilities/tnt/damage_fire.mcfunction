#> sgp.kits:abilities/tnt/damage_fire
# `{radius: double, diameter: double}`
#
# Executed as and at a lingering-fire marker.

# Most overlapping fire markers have nobody they can damage: a successful fire hit
# makes the next nine identical attempts guaranteed vanilla cooldown failures. Bail
# out locally before resolving the owner or scanning damage targets in that case.
$execute positioned ~-$(radius) ~-$(radius) ~-$(radius) \
    unless entity @e[type=player,tag=sgp.in_game,tag=!sgp.peaceful,tag=!sgp.tnt_fire_cached,dx=$(diameter),dy=$(diameter),dz=$(diameter),limit=1,sort=arbitrary] \
        run return 0

scoreboard players operation #damage_owner sgp.dummy = @s sgp.damage_owner

execute as @a \
    if score @s sgp.id = #damage_owner sgp.dummy \
        run tag @s add sgp.current_damage_owner

# Attribute other players' damage to the caster. 
# Unowned behaviour for self-damage and for a caster who is no longer online.
$execute if entity @a[tag=sgp.current_damage_owner,limit=1] \
    as @a[tag=sgp.in_game,tag=!sgp.peaceful,tag=!sgp.current_damage_owner,tag=!sgp.tnt_fire_cached,distance=..$(radius)] \
        run function sgp.kits:abilities/tnt/damage_fire_owned

$execute as @a[tag=sgp.in_game,tag=!sgp.peaceful,tag=sgp.current_damage_owner,tag=!sgp.tnt_fire_cached,distance=..$(radius)] \
    run function sgp.kits:abilities/tnt/damage_fire_unowned

$execute unless entity @a[tag=sgp.current_damage_owner,limit=1] \
    as @a[tag=sgp.in_game,tag=!sgp.peaceful,tag=!sgp.tnt_fire_cached,distance=..$(radius)] \
        run function sgp.kits:abilities/tnt/damage_fire_unowned

tag @a[tag=sgp.current_damage_owner] remove sgp.current_damage_owner

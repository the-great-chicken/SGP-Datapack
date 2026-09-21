#> sgp.kits:abilities/rays/tick_linked_children
#
# Executed as/at the caster after $link.to has been set.

# Probe the horizontal beam plane first so the common no-target path does not create/remove transient target tags at all.
execute positioned ~-16.5 ~0.1 ~-16.5 \
    unless entity @a[tag=!sgp.radiator,tag=!sgp.peaceful,gamemode=!spectator,dx=32,dy=0,dz=32,limit=1] \
        at @s run return run function sgp.kits:abilities/rays/tick_linked_children_block_only


# Resolve the attacker-side statistics context once; every hit below has this caster as its source.
function sgp.kits:stats_collector/ability/ray_caster_context

execute positioned ~-16.5 ~0.1 ~-16.5 \
    run tag @a[tag=!sgp.radiator,tag=!sgp.peaceful,gamemode=!spectator,dx=32,dy=0,dz=32] add sgp.ray_target

scoreboard players set #ray_hitbox_cache sgp.dummy 0
scoreboard players set #ray_fast_entity sgp.dummy 0

execute as @e[distance=..10,tag=sgp.ray,predicate=bs.link:link_equal,limit=8,type=item_display] \
    positioned ~ ~0.6 ~ rotated as @s \
        run function sgp.kits:abilities/rays/update_ray_dispatch

tag @a[tag=sgp.ray_target] remove sgp.ray_target

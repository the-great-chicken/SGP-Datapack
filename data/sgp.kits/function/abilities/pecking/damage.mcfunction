#> sgp.kits:abilities/pecking/damage
#
# Find the player we are pecking. Damage him every few tick.
# If we're not looking at a player anymore, start ability cooldown.

# warn-off-file execute-group

# execute as @s run function #bs.view:as_aimed_entity {run:"tag @s add sgp.is_being_pecked", with:{max_distance:5}}

# Not using bookshelf, to have a "thick" ray cuz else it's too hard, and desyncs are too frequent
tag @s add sgp.source_peck

execute positioned ^ ^ ^1.0 positioned ~ ~-0.3 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^1.0 positioned ~ ~-0.9 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^1.0 positioned ~ ~-1.5 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked

execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^2.0 positioned ~ ~-0.3 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^2.0 positioned ~ ~-0.9 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^2.0 positioned ~ ~-1.5 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked

execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^3.0 positioned ~ ~-0.3 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^3.0 positioned ~ ~-0.9 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^3.0 positioned ~ ~-1.5 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked

execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^4.0 positioned ~ ~-0.3 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^4.0 positioned ~ ~-0.9 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute unless entity @a[tag=sgp.is_being_pecked] positioned ^ ^ ^4.0 positioned ~ ~-1.5 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked

tag @s remove sgp.source_peck

# Stop pecking if not looking at player for more than 5 ticks
execute unless entity @a[tag=sgp.is_being_pecked,tag=!sgp.peaceful] run scoreboard players set @s sgp.cooldown_ability 400
execute unless entity @a[tag=sgp.is_being_pecked,tag=!sgp.peaceful] run return run tag @s remove sgp.is_pecking


# Only peck every few ticks (modifiable value)
scoreboard players add @s sgp.pecking_timer 1
execute unless score @s sgp.pecking_timer matches 2.. run return run tag @a[tag=sgp.is_being_pecked] remove sgp.is_being_pecked

damage @p[tag=sgp.is_being_pecked] 1 sgp.kits:pecking by @s
tag @a[tag=sgp.is_being_pecked] remove sgp.is_being_pecked

scoreboard players set @s sgp.pecking_timer 0
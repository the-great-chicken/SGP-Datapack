#> sgp.kits:abilities/pecking/tick
#
# Find the player we are pecking. Damage him every few tick.
# If we're not looking at a player anymore, start ability cooldown.

# warn-off-file execute-group

execute if score @s sgp.duration_ability matches 1 run return run function sgp.kits:abilities/pecking/end

# execute as @s run function #bs.view:as_aimed_entity {run:"tag @s add sgp.is_being_pecked", with:{max_distance:5}}

# Not using bookshelf, to have a "thick" ray cuz else it's too hard, and desyncs are too frequent
tag @s add sgp.source_peck

# The probes below reach at most 4 blocks ahead plus a 1-block radius: skip all of them when nobody is that close.
execute unless entity @a[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..6,limit=1] run return run function sgp.kits:abilities/pecking/no_target

# Each probe runs only until one finds a target; the flag replaces an @a scan per probe.
scoreboard players set #peck_found sgp.dummy 0
execute store success score #peck_found sgp.dummy positioned ^ ^ ^1.0 positioned ~ ~-0.3 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^1.0 positioned ~ ~-0.9 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^1.0 positioned ~ ~-1.5 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked

execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^2.0 positioned ~ ~-0.3 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^2.0 positioned ~ ~-0.9 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^2.0 positioned ~ ~-1.5 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked

execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^3.0 positioned ~ ~-0.3 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^3.0 positioned ~ ~-0.9 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^3.0 positioned ~ ~-1.5 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked

execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^4.0 positioned ~ ~-0.3 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^4.0 positioned ~ ~-0.9 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked
execute if score #peck_found sgp.dummy matches 0 store success score #peck_found sgp.dummy positioned ^ ^ ^4.0 positioned ~ ~-1.5 ~ as @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_being_pecked

tag @s remove sgp.source_peck

# Stop pecking if not looking at player
execute unless entity @a[tag=sgp.is_being_pecked,tag=!sgp.peaceful] run return run function sgp.kits:abilities/pecking/end

# Count valid lock-on time in a scoreboard and flush it only when the cast ends.
scoreboard players add @s sgp.peck_lock_ticks 1

# Only peck every few ticks (modifiable value)
scoreboard players add @s sgp.pecking_timer 1
execute unless score @s sgp.pecking_timer matches 2.. run return run tag @a[tag=sgp.is_being_pecked] remove sgp.is_being_pecked

damage @p[tag=sgp.is_being_pecked] 1.5 sgp.kits:pecking by @s
tag @a[tag=sgp.is_being_pecked] remove sgp.is_being_pecked

scoreboard players set @s sgp.pecking_timer 0

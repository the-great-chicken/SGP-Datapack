#> sgp.kits:stats_collector/pause_for_major_event
#
# Close active normal-play lives at the event boundary, then discard every
# in-flight collector-only value so results cannot cross the boundary.

execute unless score #stats_schema_version sgp.dummy matches 6 run return 0

execute store result score #stats_pause_started sgp.dummy run time query gametime
scoreboard players set #stats_paused sgp.dummy 1

execute as @a[tag=sgp.in_game,tag=!sgp.peaceful,scores={sgp.id=1..,sgp.kit_id=0..11}] \
    run function sgp.kits:stats_collector/pause_pick_as_player

scoreboard players reset * sgp.damage_taken
scoreboard players reset * sgp.death_cause
scoreboard players reset * sgp.damage_resisted
scoreboard players reset * sgp.ability_cast
scoreboard players reset * sgp.ability_kind
scoreboard players reset * sgp.ability_success
scoreboard players reset * sgp.last_ability_cast
scoreboard players reset * sgp.ability_result_window
scoreboard players reset * sgp.peck_lock_ticks
scoreboard players reset * sgp.elo_pending

scoreboard players reset #next_ability_cast sgp.dummy
tag @a remove sgp.ability_damage_target
tag @a remove sgp.stats_pecking_active
tag @a remove sgp.stats_tank_boost_active
tag @a remove sgp.elo_victim
tag @a remove sgp.elo_touched

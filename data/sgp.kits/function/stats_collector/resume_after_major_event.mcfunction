#> sgp.kits:stats_collector/resume_after_major_event
#
# Called only after the event predicate is false and synthetic cleanup deaths
# have been consumed. Begin new kit-time intervals for normal SGP play; other
# collectors require no resume action because they are event-driven.

scoreboard players set #stats_paused sgp.dummy 0

# Major-event gameplay may have touched the same detector objectives after the
# pause began. Clear them again so no delayed result can cross into normal play.
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

execute as @a[tag=sgp.in_game,tag=!sgp.peaceful,scores={sgp.id=1..,sgp.kit_id=0..11}] \
    run function sgp.kits:stats_collector/collect_kit_pick_infos

#> sgp.kits:stats_collector/reset_for_new_edition
#
# Destructive by design. Start a new Soirée du Grand Poulet statistics set
# while preserving player ids, kit assignments, and gameplay configuration.
# Run while no round or ability is active so delayed effects cannot cross the
# edition boundary.

# Remove every accumulated statistics value. Metadata is rebuilt below.
data modify storage sgp.kits:stats kits_dict set value {}
data modify storage sgp.kits:stats elo_ratings set value {}
data remove storage sgp:macro stats

# Reset the existing edition-wide kill/death, K/D, and streak scoreboards.
scoreboard players reset * sgp.just_died
scoreboard players reset * sgp.streak_reset
scoreboard players reset * sgp.morts
scoreboard players reset * sgp.kd
scoreboard players reset * sgp.plus_grande_streak
scoreboard players reset * sgp.kills
scoreboard players reset * sgp.streak_en_cours
scoreboard players reset * sgp.kills_give_1
scoreboard players reset * sgp.kills_give_2
scoreboard players reset * sgp.kills_give_3
scoreboard players reset * sgp.last_kill_count

# Clear all scoreboard-backed collector values.
scoreboard players reset * sgp.death_cause
scoreboard players reset * sgp.damage_taken
scoreboard players reset * sgp.damage_owner
scoreboard players reset * sgp.damage_resisted
scoreboard players reset * sgp.ability_cast
scoreboard players reset * sgp.ability_kind
scoreboard players reset * sgp.ability_success
scoreboard players reset * sgp.last_ability_cast
scoreboard players reset * sgp.ability_result_window
scoreboard players reset * sgp.peck_lock_ticks

scoreboard players reset * sgp.elo
scoreboard players reset * sgp.elo_pending
scoreboard players reset * sgp.elo_encounters
scoreboard players reset * sgp.elo_deaths
scoreboard players reset * sgp.elo_deaths_seen

# Clear common in-flight cast attribution before rebuilding collector state.
scoreboard players reset #next_ability_cast sgp.dummy
tag @a remove sgp.ability_damage_target
tag @a remove sgp.stats_pecking_active
tag @a remove sgp.stats_tank_boost_active
tag @a remove sgp.current_damage_owner
tag @a remove sgp.elo_victim
tag @a remove sgp.elo_touched

# Rebuild authoritative metadata and runtime lookup state, then initialize
# current participants and begin timing their current kit picks immediately.
function sgp.kits:stats_collector/init_ability_metadata
function sgp.kits:stats_collector/elo/init
execute as @a[tag=sgp.in_game,tag=!sgp.peaceful,scores={sgp.id=1..,sgp.kit_id=0..11}] \
    run function sgp.kits:stats_collector/collect_kit_pick_infos

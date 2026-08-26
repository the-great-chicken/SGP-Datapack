#> sgp.kits:stats_collector/on_real_death
#
# Consume each genuine death exactly once before special modes or normal death
# cleanup can clear sgp.just_died. The deathCount objective excludes synthetic
# cleanup and protects the immediate hurt callback plus tick fallback from
# double-counting the same death.

scoreboard players add @s sgp.elo_deaths_seen 0
execute unless score @s sgp.elo_deaths > @s sgp.elo_deaths_seen run return 0
scoreboard players operation @s sgp.elo_deaths_seen = @s sgp.elo_deaths

# Consume the genuine-death marker above even when collection is paused, so a
# major-event death cannot leak into normal statistics after the event ends.
execute unless function sgp.kits:stats_collector/can_collect run return 0

execute if entity @s[tag=sgp.in_game] \
    run function sgp.kits:stats_collector/death_position/capture

execute if entity @s[tag=sgp.in_game,tag=!sgp.peaceful,scores={sgp.id=1..,sgp.kit_id=0..11}] \
    run function sgp.kits:stats_collector/elo/on_real_death

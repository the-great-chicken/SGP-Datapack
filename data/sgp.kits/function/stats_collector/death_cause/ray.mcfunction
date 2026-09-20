#> sgp.kits:stats_collector/death_cause/ray
#
# Final damage mechanism: ray (102). Rays have a known player source and ability,
# so collect the event without routing through the generic ability-damage dispatcher.

execute if entity @s[tag=sgp.tnt_fire_cached] run function sgp.kits:abilities/tnt/clear_fire_cooldown
scoreboard players set @s sgp.death_cause 102
advancement revoke @s only sgp.kits:death_cause/ray

# Preserve lethal-hit handling at the victim's exact damage position.
execute if entity @s[scores={sgp.just_died=1..}] \
    run function sgp.kits:stats_collector/on_real_death

execute if function sgp.kits:stats_collector/can_collect \
    if entity @s[tag=sgp.in_game,scores={sgp.damage_taken=1..}] \
        run function sgp.kits:stats_collector/collect_ray_damage_received_valid

# Match the generic collector: this custom-stat objective is a per-event delta.
scoreboard players reset @s sgp.damage_taken

# Final damage mechanism: giant_sweep (100)
execute if entity @s[tag=sgp.tnt_fire_cached] run function sgp.kits:abilities/tnt/clear_fire_cooldown
scoreboard players set @s sgp.death_cause 100
advancement revoke @s only sgp.kits:death_cause/giant_sweep
function sgp.kits:stats_collector/collect_damage_received

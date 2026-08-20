# Final damage mechanism: giant_sweep (100)
scoreboard players set @s sgp.death_cause 100
advancement revoke @s only sgp.kits:death_cause/giant_sweep
function sgp.kits:stats_collector/collect_damage_received

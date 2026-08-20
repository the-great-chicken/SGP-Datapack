# Final damage mechanism: fire_tick (11)
scoreboard players set @s sgp.death_cause 11
advancement revoke @s only sgp.kits:death_cause/fire_tick
function sgp.kits:stats_collector/collect_damage_received

# Final damage mechanism: impact (19)
scoreboard players set @s sgp.death_cause 19
advancement revoke @s only sgp.kits:death_cause/impact
function sgp.kits:stats_collector/collect_damage_received

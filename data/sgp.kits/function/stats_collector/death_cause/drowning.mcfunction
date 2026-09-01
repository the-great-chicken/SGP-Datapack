# Final damage mechanism: drowning (20)
scoreboard players set @s sgp.death_cause 20
advancement revoke @s only sgp.kits:death_cause/drowning
function sgp.kits:stats_collector/collect_damage_received

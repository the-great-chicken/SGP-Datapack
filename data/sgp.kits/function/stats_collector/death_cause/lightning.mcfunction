# Final damage mechanism: lightning (24)
scoreboard players set @s sgp.death_cause 24
advancement revoke @s only sgp.kits:death_cause/lightning
function sgp.kits:stats_collector/collect_damage_received

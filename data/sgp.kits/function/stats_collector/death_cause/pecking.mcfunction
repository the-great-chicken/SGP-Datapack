# Final damage mechanism: pecking (101)
scoreboard players set @s sgp.death_cause 101
advancement revoke @s only sgp.kits:death_cause/pecking
function sgp.kits:stats_collector/collect_damage_received

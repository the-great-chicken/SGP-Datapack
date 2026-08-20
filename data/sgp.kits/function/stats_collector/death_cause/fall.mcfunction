# Final damage mechanism: fall (18)
scoreboard players set @s sgp.death_cause 18
advancement revoke @s only sgp.kits:death_cause/fall
function sgp.kits:stats_collector/collect_damage_received

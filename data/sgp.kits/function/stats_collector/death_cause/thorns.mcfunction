# Final damage mechanism: thorns (17)
scoreboard players set @s sgp.death_cause 17
advancement revoke @s only sgp.kits:death_cause/thorns
function sgp.kits:stats_collector/collect_damage_received

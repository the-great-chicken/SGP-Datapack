# Final damage mechanism: magic_effect (16)
scoreboard players set @s sgp.death_cause 16
advancement revoke @s only sgp.kits:death_cause/magic_effect
function sgp.kits:stats_collector/collect_damage_received

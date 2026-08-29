# Final damage mechanism: environmental_contact (26)
scoreboard players set @s sgp.death_cause 26
advancement revoke @s only sgp.kits:death_cause/environmental_contact
function sgp.kits:stats_collector/collect_damage_received

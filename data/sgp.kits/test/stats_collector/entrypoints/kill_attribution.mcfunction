#> sgp.kits:stats_collector/entrypoints/kill_attribution
# @dummy
# @environment sgp.ci:stats_collector_guarded
#
# The real kill entrypoint reads vanilla's attacker relation, records both kits and the final cause, clears transient cause state, and honors the collector pause gate.

scoreboard players set #stats_schema_version sgp.dummy 7
scoreboard players set #stats_paused sgp.dummy 0
scoreboard players set @s sgp.id 910020
scoreboard players set @s sgp.kit_id 7
scoreboard players set @s sgp.death_cause 100

dummy StatsKiller spawn
gamemode survival StatsKiller
tp StatsKiller ~1 ~ ~
scoreboard players set StatsKiller sgp.id 910019
scoreboard players set StatsKiller sgp.kit_id 1
damage @s 1 minecraft:player_attack by StatsKiller
execute on attacker run assert entity @s[name=StatsKiller]

function sgp.kits:stats_collector/collect_kill_infos
execute store result storage sgp.ci:stats entry_kill.recorded int 1 run data get storage sgp.kits:stats kits_dict.910019.1.kills.910020.7.100
assert data storage sgp.ci:stats entry_kill{recorded:1}
assert score @s sgp.death_cause matches 0

scoreboard players set #stats_paused sgp.dummy 1
scoreboard players set @s sgp.death_cause 17
function sgp.kits:stats_collector/collect_kill_infos
assert not data storage sgp.kits:stats kits_dict.910019.1.kills.910020.7.17
assert score @s sgp.death_cause matches 0

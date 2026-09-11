#> sgp.kits:stats_collector/entrypoints/kill_attribution
# @dummy
# @environment sgp.ci:stats_collector_guarded/entrypoints/kill_attribution
#
# The real kill entrypoint reads vanilla's attacker relation, records both kits and the final cause, clears transient cause state, and honors the collector pause gate.

scoreboard players set #stats_schema_version sgp.dummy 7
scoreboard players set #stats_paused sgp.dummy 0
scoreboard players set @s sgp.id 910019
scoreboard players set @s sgp.kit_id 1
gamemode creative @s

# Give the dummy a local solid pad so the loading wait cannot turn into a
# fall/void test. The victim remains creative until the actual hit.
fill ~ ~-1 ~ ~2 ~-1 ~ minecraft:stone
fill ~ ~ ~ ~2 ~2 ~ minecraft:air

# Keep the spawned victim protected while PackTest's dummy client finishes loading.
# The proven cosmetics combat fixture also uses a creative attacker and only relies
# on the victim being in survival at the moment damage is applied.
dummy StatsVictim spawn
gamemode creative StatsVictim
tp StatsVictim ~1.5 ~ ~0.5
scoreboard players set StatsVictim sgp.id 910020
scoreboard players set StatsVictim sgp.kit_id 7

# Wait out PackTest's dummy client-loading protection while the victim is safe,
# then switch to the exact combat shape used by the passing kill-effect fixture.
await delay 61t
tp StatsVictim ~1.5 ~ ~0.5
gamemode survival StatsVictim
effect clear StatsVictim
effect give StatsVictim minecraft:instant_health 1 4 true

# Health is deliberately not asserted here: the collector contract depends on
# vanilla's attacker relation, not an exact incidental HP value.
damage StatsVictim 1 minecraft:player_attack by @s
execute as StatsVictim on attacker run tag @s add sgp.ci.stats_kill_attacker
assert entity @s[tag=sgp.ci.stats_kill_attacker]

# The real player_attack above legitimately classifies the damage as cause 1.
# This test is about kill-attribution persistence, so install the synthetic
# final cause only after the combat context has been established.
scoreboard players set StatsVictim sgp.death_cause 100
execute as StatsVictim run function sgp.kits:stats_collector/collect_kill_infos
execute store result storage sgp.ci:stats entry_kill.recorded int 1 run data get storage sgp.kits:stats kits_dict.910019.1.kills.910020.7.100
assert data storage sgp.ci:stats entry_kill{recorded:1}
assert score StatsVictim sgp.death_cause matches 0

scoreboard players set #stats_paused sgp.dummy 1
scoreboard players set StatsVictim sgp.death_cause 17
execute as StatsVictim run function sgp.kits:stats_collector/collect_kill_infos
assert not data storage sgp.kits:stats kits_dict.910019.1.kills.910020.7.17
assert score StatsVictim sgp.death_cause matches 0

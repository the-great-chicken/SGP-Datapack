#> sgp.kits:stats_collector/entrypoints/elo_real_death
# @dummy
# @environment sgp.ci:stats_collector_guarded
#
# The real-death Elo entrypoint follows vanilla's attacker relation and creates one zero-sum pending transfer without leaking its victim marker.

scoreboard players set #stats_schema_version sgp.dummy 7
scoreboard players set #stats_paused sgp.dummy 0
tag @s add sgp.in_game
scoreboard players set @s sgp.id 910022
scoreboard players set @s sgp.kit_id 1
scoreboard players set @s sgp.elo 100000
scoreboard players set @s sgp.elo_pending 0
scoreboard players set @s sgp.elo_encounters 0

dummy StatsEloK spawn
gamemode survival StatsEloK
tp StatsEloK ~1 ~ ~
tag StatsEloK add sgp.in_game
scoreboard players set StatsEloK sgp.id 910023
scoreboard players set StatsEloK sgp.kit_id 2
scoreboard players set StatsEloK sgp.elo 100000
scoreboard players set StatsEloK sgp.elo_pending 0
scoreboard players set StatsEloK sgp.elo_encounters 0

damage @s 1 minecraft:player_attack by StatsEloK
execute on attacker run assert entity @s[name=StatsEloK]
function sgp.kits:stats_collector/elo/on_real_death

assert score @s sgp.elo_pending matches ..-1
assert score StatsEloK sgp.elo_pending matches 1..
scoreboard players operation @s sgp.dummy = @s sgp.elo_pending
scoreboard players operation @s sgp.dummy += StatsEloK sgp.elo_pending
assert score @s sgp.dummy matches 0
assert score @s sgp.elo_encounters matches 1
assert score StatsEloK sgp.elo_encounters matches 1
assert entity @s[tag=sgp.elo_touched]
assert entity StatsEloK[tag=sgp.elo_touched]
assert not entity @a[tag=sgp.elo_victim]

#> sgp.kits:stats_collector/entrypoints/elo_real_death
# @dummy
# @environment sgp.ci:stats_collector_guarded/entrypoints/elo_real_death
#
# The real-death Elo entrypoint follows vanilla's attacker relation and creates one zero-sum pending transfer without leaking its victim marker.

scoreboard players set #stats_schema_version sgp.dummy 7
scoreboard players set #stats_paused sgp.dummy 0
tag @s add sgp.in_game
scoreboard players set @s sgp.id 910023
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.elo 100000
scoreboard players set @s sgp.elo_pending 0
scoreboard players set @s sgp.elo_encounters 0
gamemode creative @s

# Keep the combat pair on a local solid pad; this test is about attribution,
# not environmental damage during PackTest's loading grace period.
fill ~ ~-1 ~ ~2 ~-1 ~ minecraft:stone
fill ~ ~ ~ ~2 ~2 ~ minecraft:air

# Keep the victim protected during the PackTest dummy loading window. The attacker
# stays creative, matching the already-passing cosmetics attacker fixture.
dummy StatsEloV spawn
gamemode creative StatsEloV
tp StatsEloV ~1.5 ~ ~0.5
tag StatsEloV add sgp.in_game
scoreboard players set StatsEloV sgp.id 910022
scoreboard players set StatsEloV sgp.kit_id 1
scoreboard players set StatsEloV sgp.elo 100000
scoreboard players set StatsEloV sgp.elo_pending 0
scoreboard players set StatsEloV sgp.elo_encounters 0

# Wait out the same 61-tick protection window, then make the victim damageable
# immediately before creating the attacker relation.
await delay 61t
tp StatsEloV ~1.5 ~ ~0.5
gamemode survival StatsEloV
effect clear StatsEloV
effect give StatsEloV minecraft:instant_health 1 4 true

# As above, prove the relation directly instead of coupling the test to exact HP.
damage StatsEloV 1 minecraft:player_attack by @s
execute as StatsEloV on attacker run tag @s add sgp.ci.stats_elo_attacker
assert entity @s[tag=sgp.ci.stats_elo_attacker]
execute as StatsEloV run function sgp.kits:stats_collector/elo/on_real_death

assert score StatsEloV sgp.elo_pending matches ..-1
assert score @s sgp.elo_pending matches 1..
scoreboard players operation @s sgp.dummy = StatsEloV sgp.elo_pending
scoreboard players operation @s sgp.dummy += @s sgp.elo_pending
assert score @s sgp.dummy matches 0
assert score StatsEloV sgp.elo_encounters matches 1
assert score @s sgp.elo_encounters matches 1
assert entity @a[name=StatsEloV,tag=sgp.elo_touched]
assert entity @s[tag=sgp.elo_touched]
assert not entity @a[tag=sgp.elo_victim]

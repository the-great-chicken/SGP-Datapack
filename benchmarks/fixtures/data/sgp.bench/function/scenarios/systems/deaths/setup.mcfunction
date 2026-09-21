#> sgp.bench:scenarios/systems/deaths/setup
# `{first: int, last: int, players: int, period: int, victims: int}`
#
# The kits_idle roster (12 kits round-robin, sgp.bench.clock = local index % 12) plus a
# deathCount objective the tick function uses to find actors that died.

scoreboard objectives add sgp.bench.deaths deathCount
$function sgp.bench:scenarios/kits_idle/setup {first:$(first),last:$(last),players:$(players)}
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.deaths 0
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.bench.respawning
$scoreboard players set #deaths_first sgp.bench $(first)
$scoreboard players set #deaths_players sgp.bench $(players)
$scoreboard players set #deaths_period sgp.bench $(period)
$scoreboard players set #deaths_victims sgp.bench $(victims)
scoreboard players set #deaths_cursor sgp.bench 0
scoreboard players set #deaths_phase sgp.bench 0

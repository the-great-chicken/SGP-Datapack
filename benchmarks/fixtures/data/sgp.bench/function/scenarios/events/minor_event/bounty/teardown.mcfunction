#> sgp.bench:scenarios/events/minor_event/bounty/teardown
# `{first, last, players, event}`
function sgp.mineurs:bounty/stop
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.reward
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bounty_gen

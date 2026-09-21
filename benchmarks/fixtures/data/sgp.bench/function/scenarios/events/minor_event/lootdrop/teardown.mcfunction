#> sgp.bench:scenarios/events/minor_event/lootdrop/teardown
# `{first, last, players, event}`
function sgp.mineurs:lootdrop/clear_existing_ones
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.bench.sharer
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.share_item
kill @e[tag=sgp.bench.lootdrop,type=marker]
data remove storage sgp:data markers_lists.lootdrop

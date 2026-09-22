#> sgp.bench:scenarios/events/minor_event/lootdrop/tick
# `{first, last, players, event}`
# Every 40 ticks two actors share their held item (tellraw to every in-game player each).
scoreboard players operation #minor_mod sgp.bench = #minor_phase sgp.bench
scoreboard players operation #minor_mod sgp.bench %= #minor_c40 sgp.bench
execute unless score #minor_mod sgp.bench matches 0 run return 0
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=sgp.bench.sharer] sgp.share_item 1
scoreboard players add #minor_actions sgp.bench 2

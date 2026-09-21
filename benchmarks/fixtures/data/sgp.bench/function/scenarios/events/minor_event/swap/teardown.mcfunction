#> sgp.bench:scenarios/events/minor_event/swap/teardown
# `{first, last, players, event}`
kill @e[tag=sgp.bench.choose_kit,type=interaction]
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.pigeon_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.combattant_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.archer_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.vindicateur_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.pyromane_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.tank_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.roi_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.eclaireur_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.alchimiste_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.enderman_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cancer_found
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.poseidon_found

#> sgp.bench:scenarios/kits_idle/setup
# `{first: int, last: int, players: int}`
# Assign this component's players across the combat kits using their local actor index.

scoreboard players set #kit_count sgp.bench 12
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run scoreboard players operation @s sgp.bench.clock = @s sgp.bench
$scoreboard players remove @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock $(first)
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run scoreboard players operation @s sgp.bench.clock %= #kit_count sgp.bench

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=0}] run function sgp.kits:give {kit:"pigeon"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=1}] run function sgp.kits:give {kit:"combattant"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=2}] run function sgp.kits:give {kit:"archer"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=3}] run function sgp.kits:give {kit:"vindicateur"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=4}] run function sgp.kits:give {kit:"pyromane"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=5}] run function sgp.kits:give {kit:"tank"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=6}] run function sgp.kits:give {kit:"roi"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=7}] run function sgp.kits:give {kit:"eclaireur"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=8}] run function sgp.kits:give {kit:"alchimiste"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=9}] run function sgp.kits:give {kit:"enderman"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=10}] run function sgp.kits:give {kit:"cancer"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=11}] run function sgp.kits:give {kit:"poseidon"}
function sgp.kits:kit_tags/management

#> sgp.bench:scenarios/abilities/common/setup_kit
# `{first: int, last: int, kit: string}`
# Give one actor range its production kit and enough health to keep benchmark
# actors alive while abilities interact with each other.

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:give {kit:"$(kit)"}
function sgp.kits:kit_tags/management
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] unless score @s bs.id matches 1.. run function #bs.id:give_suid
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:max_health base set 1024
$effect give @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:instant_health 1 10 true

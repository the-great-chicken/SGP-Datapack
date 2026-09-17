#> sgp.bench:scenarios/ability_rays/setup
# `{first: int, last: int, players: int}`

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:give {kit:"roi"}
function sgp.kits:kit_tags/management
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] unless score @s bs.id matches 1.. run function #bs.id:give_suid
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.kits:abilities/rays/start
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] add sgp.peaceful
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.duration_ability 120000

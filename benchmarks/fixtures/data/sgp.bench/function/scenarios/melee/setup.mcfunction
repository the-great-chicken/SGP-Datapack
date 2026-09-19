#> sgp.bench:scenarios/melee/setup
# `{first: int, last: int, players: int, period: int}`
# Split the component between two close positions so every actor has an opposing target in reach.

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:give {kit:"combattant"}
function sgp.kits:kit_tags/management
scoreboard players set #melee_two sgp.bench 2
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run scoreboard players operation @s sgp.bench.clock = @s sgp.bench
$scoreboard players remove @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock $(first)
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run scoreboard players operation @s sgp.bench.clock %= #melee_two sgp.bench
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=0}] add sgp.bench.melee.left
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=1}] add sgp.bench.melee.right
$tp @a[tag=sgp.bench.melee.left,scores={sgp.bench=$(first)..$(last)}] -1 81 25.5 -90 0
$tp @a[tag=sgp.bench.melee.right,scores={sgp.bench=$(first)..$(last)}] 1 81 25.5 90 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:max_health base set 200
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:knockback_resistance base set 1
$effect give @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:instant_health 1 6 true
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0

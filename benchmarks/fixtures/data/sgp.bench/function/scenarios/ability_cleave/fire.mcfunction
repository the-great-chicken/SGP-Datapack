#> sgp.bench:scenarios/ability_cleave/fire
# `{first: int, last: int, players: int}`
# Force this component's abilities ready, then use PackTest's actual drop interaction.

$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cooldown_ability 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run dummy @s drop
$scoreboard players add #actions sgp.bench $(players)
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0

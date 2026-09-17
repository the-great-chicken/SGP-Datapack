#> sgp.bench:scenarios/ability_cleave/setup
# `{first: int, last: int, players: int, period: int}`
# Configure only this component's contiguous actor range.

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:give {kit:"combattant"}
function sgp.kits:kit_tags/management
$item replace entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] weapon.mainhand with minecraft:stone 64
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cooldown_ability 0
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0

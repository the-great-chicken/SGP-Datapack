#> sgp.bench:scenarios/abilities/common/setup_drop
# `{first: int, last: int, kit: string}`

$function sgp.bench:scenarios/abilities/common/setup_kit {first:$(first),last:$(last),kit:"$(kit)"}
$item replace entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] weapon.mainhand with minecraft:stone 64
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cooldown_ability 0
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0

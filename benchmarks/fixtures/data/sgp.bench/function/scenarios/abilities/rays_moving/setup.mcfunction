#> sgp.bench:scenarios/abilities/rays_moving/setup
# `{first: int, last: int, players: int}`
# Same isolated cells as ability_rays, but every actor faces a different direction and walks
# forward each tick, so the beams' predicted displacement differs per caster like in a real game.
$function sgp.bench:scenarios/abilities/rays/setup {first:$(first),last:$(last),players:$(players)}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/rays_moving/face {first:$(first)}
scoreboard players set #rays_moving_phase sgp.bench 0

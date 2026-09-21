#> sgp.bench:scenarios/systems/deaths/wave
# Kill victims cursor..cursor+victims-1 (actor indexes modulo players); the killer of each is
# the actor `victims` slots further, which is alive by construction.

execute if score #deaths_k sgp.bench >= #deaths_victims sgp.bench run return 0
scoreboard players operation #deaths_v sgp.bench = #deaths_cursor sgp.bench
scoreboard players operation #deaths_v sgp.bench += #deaths_k sgp.bench
scoreboard players operation #deaths_kl sgp.bench = #deaths_v sgp.bench
scoreboard players operation #deaths_kl sgp.bench += #deaths_victims sgp.bench
scoreboard players operation #deaths_v sgp.bench %= #deaths_players sgp.bench
scoreboard players operation #deaths_kl sgp.bench %= #deaths_players sgp.bench
scoreboard players operation #deaths_v sgp.bench += #deaths_first sgp.bench
scoreboard players operation #deaths_kl sgp.bench += #deaths_first sgp.bench
execute store result storage sgp.bench:deaths args.victim int 1 run scoreboard players get #deaths_v sgp.bench
execute store result storage sgp.bench:deaths args.killer int 1 run scoreboard players get #deaths_kl sgp.bench
function sgp.bench:scenarios/systems/deaths/kill_one with storage sgp.bench:deaths args
scoreboard players add #deaths_k sgp.bench 1
function sgp.bench:scenarios/systems/deaths/wave

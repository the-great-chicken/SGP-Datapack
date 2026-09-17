
#> sgp.bench:scenarios/abilities/assassinate_triggered/setup_attacker
# Executed as/at one Enderman actor.
#
# Put a harmless attacker four blocks above the actor. A full column two blocks
# behind it rejects all four far-Y candidates; a single low block one block
# behind rejects the first two near candidates, forcing the production search
# deep into its fallback path before succeeding at the raised position.

summon husk ~ ~4 ~ {Tags:["sgp.bench.assassin_attacker","sgp.bench.entity","sgp.peaceful"],NoAI:1b,NoGravity:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Rotation:[0f,0f]}
fill ~ ~4 ~-2 ~ ~7 ~-2 minecraft:stone
setblock ~ ~4 ~-1 minecraft:stone

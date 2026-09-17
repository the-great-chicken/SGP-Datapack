#> sgp.bench:reset
# Stop workload generation before tearing down anything it owns.

scoreboard players set #enabled sgp.bench 0
execute if score #plan_ready sgp.bench matches 1 run function sgp.bench:generated/active/teardown
scoreboard players set #plan_ready sgp.bench 0
function sgp.bench:actors/cleanup
kill @e[tag=sgp.bench.entity]
scoreboard players set #players sgp.bench 0
scoreboard players set #ticks sgp.bench 0
scoreboard players set #actions sgp.bench 0

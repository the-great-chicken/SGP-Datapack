#> sgp.kits:ability_entrypoints/pecking
# @dummy
# @environment sgp.ci:ability_entrypoints/pecking
#
# Pigeon routing must acquire a valid target before opening the five-second pecking window.

function sgp.ci:ability_entrypoints/seed_stats {id:920006,kit:0,ability:"pecking"}
tag @s add sgp.pigeon
gamemode survival @s
tp @s ~4.5 ~1 ~4.5 0 0
scoreboard players set @s sgp.cooldown_ability 0
scoreboard players set @s sgp.pecking_timer 0

dummy PeckRoute spawn
gamemode survival PeckRoute
execute at @s rotated as @s run tp PeckRoute ^ ^ ^2 0 0

execute at @s run function sgp.kits:abilities/route_ability

assert entity @s[tag=sgp.is_pecking,tag=sgp.stats_pecking_active]
assert score @s sgp.duration_ability matches 100
assert score @s sgp.peck_lock_ticks matches 1
assert score @s sgp.cooldown_ability matches 0

# Ending a successful route must flush/reset the lock metric and start the configured cooldown.
function sgp.kits:abilities/pecking/end
function sgp.ci:ability_entrypoints/expect_cooldown {ability:"pecking"}
assert not entity @s[tag=sgp.is_pecking]
assert not entity @s[tag=sgp.stats_pecking_active]
execute store success score #ci.ability.lock_present sgp.dummy if score @s sgp.peck_lock_ticks = @s sgp.peck_lock_ticks
assert score #ci.ability.lock_present sgp.dummy matches 0

#> sgp.kits:stats_collector/collect_damage_received
#
# Consume the damage_taken increment produced by the current hurt event.
# The score is cleared even while collection is paused, so damage from a major
# event can never leak into the next normal-play hurt event.

execute if function sgp.kits:stats_collector/can_collect \
    if entity @s[tag=sgp.in_game,scores={sgp.damage_taken=1..}] \
    run function sgp.kits:stats_collector/collect_damage_received_valid

# The custom-stat objective is used as a per-event delta, not as a cumulative score.
# Always clear it, including for damage outside a game and fully absorbed hits.
scoreboard players reset @s sgp.damage_taken

#> sgp.kits:stats_collector/collect_damage_received
#
# Consume the damage_taken increment produced by the current hurt event.
# The score is cleared even while collection is paused, so damage from a major
# event can never leak into the next normal-play hurt event.

# On a lethal hurt event this callback still has the victim's exact death
# coordinates. The tick-level caller is retained as a once-only fallback.
execute if entity @s[scores={sgp.just_died=1..}] \
    run function sgp.kits:stats_collector/on_real_death

execute if function sgp.kits:stats_collector/can_collect \
    if entity @s[tag=sgp.in_game,scores={sgp.damage_taken=1..}] \
    run function sgp.kits:stats_collector/collect_damage_received_valid

# The custom-stat objective is used as a per-event delta, not as a cumulative score.
# Always clear it, including for damage outside a game and fully absorbed hits.
scoreboard players reset @s sgp.damage_taken

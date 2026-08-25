#> sgp.kits:stats_collector/elo/on_real_death
#
# Executed before any special-mode death handler. The independent deathCount
# distinguishes genuine deaths from manual calls and synthetic cleanup.

scoreboard players add @s sgp.elo_deaths_seen 0
execute unless score @s sgp.elo_deaths > @s sgp.elo_deaths_seen run return 0
scoreboard players operation @s sgp.elo_deaths_seen = @s sgp.elo_deaths

# Always consume the real-death marker above, then use the shared collection
# gate so Elo pauses at exactly the same boundary as every other statistic.
execute unless function sgp.kits:stats_collector/can_collect run return 0

execute unless entity @s[tag=sgp.in_game,tag=!sgp.peaceful,scores={sgp.id=1..,sgp.kit_id=0..11}] run return 0

function sgp.kits:stats_collector/elo/ensure_player

tag @s add sgp.elo_victim
execute on attacker \
    if entity @s[type=minecraft:player,tag=sgp.in_game,tag=!sgp.peaceful,scores={sgp.id=1..,sgp.kit_id=0..11}] \
    unless score @s sgp.id = @a[tag=sgp.elo_victim,limit=1] sgp.id \
        run function sgp.kits:stats_collector/elo/collect_as_killer
tag @s remove sgp.elo_victim

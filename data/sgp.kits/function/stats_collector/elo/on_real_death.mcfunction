#> sgp.kits:stats_collector/elo/on_real_death
#
# Called by the shared genuine-death handler for an eligible victim.

function sgp.kits:stats_collector/elo/ensure_player

tag @s add sgp.elo_victim
execute on attacker \
    if entity @s[type=minecraft:player,tag=sgp.in_game,tag=!sgp.peaceful,scores={sgp.id=1..,sgp.kit_id=0..11}] \
    unless score @s sgp.id = @a[tag=sgp.elo_victim,limit=1] sgp.id \
        run function sgp.kits:stats_collector/elo/collect_as_killer
tag @s remove sgp.elo_victim

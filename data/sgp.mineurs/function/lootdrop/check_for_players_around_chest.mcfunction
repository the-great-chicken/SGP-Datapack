#> sgp.mineurs:lootdrop/check_for_players_around_chest

execute as @e[tag=sgp.marker,name="Lootdrop",tag=!sgp.glow_spawned,type=marker] at @s \
    if block ~ ~ ~ trapped_chest \
    if entity @a[tag=sgp.in_game,tag=!sgp.peaceful,distance=..12] \
       run function sgp.mineurs:lootdrop/summon_glow

schedule function sgp.mineurs:lootdrop/check_for_players_around_chest 10t
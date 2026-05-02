#> sgp.misc:128_ticks_functions

scoreboard players add #128_ticks_clock sgp.dummy 1

execute unless score #128_ticks_clock sgp.dummy matches 128 run return 0

execute unless entity @a[predicate=sgp.majeurs:event_in_progress] \
    run function sgp.misc:kill_streaks_management

execute unless entity @a[predicate=sgp.majeurs:event_in_progress] \
    as @a[tag=sgp.in_game] \
        run function sgp.misc:kd_buffs_and_debuffs/main

execute as @a run function sgp.misc:scoreboards/player_initialization

execute store result score #nbr_lieu sgp.lieu_count \
    if entity @e[type=marker,tag=sgp.marker,name="lieu"]

execute at @e[type=marker,tag=sgp.marker,name="respawn",limit=1] \
    run spawnpoint @a ~ ~ ~ ~ ~

scoreboard players set #128_ticks_clock sgp.dummy 0
#> sgp.kits:give
# `{kit}`
# 
# Gives a kit to the player

# Finalize a running interval while sgp.kit_id still identifies its kit. If
# this is a live kit swap, start the replacement interval after the new id is
# assigned. Normal lobby selection has no interval yet and still starts at spawn.
scoreboard players set #restart_pick sgp.dummy 0
execute store result score #restart_pick sgp.dummy \
    run function sgp.kits:stats_collector/pause_pick_as_player

function sgp.kits:clear

$function sgp.kits:collection/$(kit)/items

$tag @s add sgp.$(kit)_voulu
scoreboard players set @s sgp.reset_tags 1

$function sgp.kits:collection/$(kit)/specifics

scoreboard players set @s sgp.kit_prefix_set 0

execute if score #restart_pick sgp.dummy matches 1 \
    if function sgp.kits:stats_collector/can_collect \
        run function sgp.kits:stats_collector/collect_kit_pick_infos

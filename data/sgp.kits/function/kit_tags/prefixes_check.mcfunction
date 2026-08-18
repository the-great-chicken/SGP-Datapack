#> sgp.kits:kit_tags/prefixes_check
#
# Find a player that needs his kit prefix changed, and call the update function
# with the correct kit

schedule function sgp.kits:kit_tags/prefixes_check 1t

execute if entity @a[tag=sgp.in_game] run playerlist

execute unless entity @a[scores={sgp.kit_prefix_set=0}] run return 0

tag @r[scores={sgp.kit_prefix_set=0}] add sgp.adding_prefix

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.alchimiste,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:alchimiste}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.archer,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:archer}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.cancer,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:cancer}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.combattant,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:combattant}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.eclaireur,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:eclaireur}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.enderman,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:enderman}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.peaceful,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:peaceful}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.pigeon,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:pigeon}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.poseidon,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:poseidon}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.pyromane,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:pyromane}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.roi,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:roi}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.tank,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:tank}

execute if entity @a[tag=sgp.adding_prefix,tag=sgp.vindicateur,limit=1] \
    run return run function sgp.kits:kit_tags/prefix_update {kit_name:vindicateur}

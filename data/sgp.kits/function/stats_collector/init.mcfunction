#> sgp.kits:stats_collector/init
#
# Initialize a fresh schema, validate an existing one, and rebuild metadata.
# This function never migrates or relabels data from another schema version.

# Never let a previous load's cache authorize collection after validation fails.
scoreboard players reset #stats_schema_version sgp.dummy

# A populated pre-versioned storage is old data, not a fresh installation.
execute unless data storage sgp.kits:stats schema_version \
    if data storage sgp.kits:stats kits_dict \
        run tellraw @a [{text:"[SGP stats] ",color:red,bold:true},{text:"The statistics storage has no supported schema version. Collection is disabled; reset it before a new edition with /function sgp.kits:stats_collector/reset_for_new_edition.",color:red}]
execute unless data storage sgp.kits:stats schema_version \
    if data storage sgp.kits:stats kits_dict \
        run return 0

# Only an actually fresh storage receives the current version automatically.
execute unless data storage sgp.kits:stats schema_version \
    run data modify storage sgp.kits:stats schema_version set value 5

execute store result score #stats_schema_version sgp.dummy \
    run data get storage sgp.kits:stats schema_version

execute unless score #stats_schema_version sgp.dummy matches 5 \
    run tellraw @a [{text:"[SGP stats] ",color:red,bold:true},{text:"Unsupported statistics schema. Collection is disabled; reset it before a new edition with /function sgp.kits:stats_collector/reset_for_new_edition.",color:red}]
execute unless score #stats_schema_version sgp.dummy matches 5 run return 0

scoreboard players add #stats_paused_ticks sgp.dummy 0

# Preserve an in-progress pause across reloads. When upgrading during an event,
# only the still-observable portion can be excluded from legacy intervals.
execute if score #stats_paused sgp.dummy matches 1 \
    unless score #stats_pause_started sgp.dummy = #stats_pause_started sgp.dummy \
        store result score #stats_pause_started sgp.dummy run time query gametime

execute unless data storage sgp.kits:stats kits_dict \
    run data modify storage sgp.kits:stats kits_dict set value {}

# Stable final-damage-mechanism ids shared by kills and damage_received.
data modify storage sgp.kits:stats damage_cause_names set value {"0":"unknown","1":"player_attack","2":"mace_smash","3":"spear","4":"arrow","5":"trident","6":"mob_projectile","7":"fireball","8":"wind_charge","9":"sonic_boom","10":"fireworks","11":"fire_tick","12":"fire_contact","13":"lava","14":"explosion","15":"indirect_magic","16":"magic_effect","17":"thorns","18":"fall","19":"impact","20":"drowning","21":"suffocation","22":"starvation","23":"freezing","24":"lightning","25":"void_border","26":"environmental_contact","27":"mob_attack","28":"generic","100":"giant_sweep","101":"pecking","102":"ray"}

function sgp.kits:stats_collector/init_ability_metadata
function sgp.kits:stats_collector/elo/init

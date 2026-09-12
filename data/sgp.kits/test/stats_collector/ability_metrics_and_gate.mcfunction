#> sgp.kits:stats_collector/ability_metrics_and_gate
# @dummy
# @environment sgp.ci:stats_collector_guarded
#
# Ability metrics accumulate independently, while paused or unsupported collector states reject writes.

scoreboard players set #stats_schema_version sgp.dummy 7
scoreboard players set #stats_paused sgp.dummy 0
scoreboard players set @s sgp.id 910013

function sgp.kits:stats_collector/ability/increment {kit_id:1,ability_path:"cleave",metric:"successful_uses",amount:2}
function sgp.kits:stats_collector/ability/increment {kit_id:1,ability_path:"cleave",metric:"successful_uses",amount:3}
function sgp.kits:stats_collector/ability/increment {kit_id:1,ability_path:"cleave",metric:"affected_players",amount:1}

scoreboard players set #stats_paused sgp.dummy 1
function sgp.kits:stats_collector/ability/increment {kit_id:1,ability_path:"cleave",metric:"successful_uses",amount:99}
scoreboard players set #stats_paused sgp.dummy 0
scoreboard players set #stats_schema_version sgp.dummy 6
function sgp.kits:stats_collector/ability/increment {kit_id:1,ability_path:"cleave",metric:"affected_players",amount:99}

execute store result storage sgp.ci:stats ability.successful_uses int 1 run data get storage sgp.kits:stats kits_dict.910013.1.abilities.cleave.successful_uses
execute store result storage sgp.ci:stats ability.affected_players int 1 run data get storage sgp.kits:stats kits_dict.910013.1.abilities.cleave.affected_players
function sgp.ci:stats_collector/restore_runtime_globals

assert data storage sgp.ci:stats ability{successful_uses:5,affected_players:1}

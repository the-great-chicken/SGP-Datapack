#> sgp.kits:stats_collector/entrypoints/ability_lifecycle
# @dummy
# @environment sgp.ci:stats_collector_guarded
#
# Public ability telemetry opens one cast, counts each victim once, marks success once, and accumulates Tank boosted damage per hit.

scoreboard players set #stats_schema_version sgp.dummy 7
scoreboard players set #stats_paused sgp.dummy 0
scoreboard players set @s sgp.id 910018
scoreboard players set @s sgp.last_ability_cast -1

function sgp.kits:stats_collector/ability/start {kit_id:1,ability_path:"cleave"}
assert score @s sgp.ability_cast matches 1..
assert score @s sgp.ability_kind matches 1
assert score @s sgp.ability_success matches 0
assert data storage sgp.kits:stats kits_dict.910018.1.abilities.cleave{uses:1}

tag @s add sgp.ability_damage_target
function sgp.kits:stats_collector/ability/mark_affected {kit_id:1,ability_path:"cleave"}
function sgp.kits:stats_collector/ability/mark_affected {kit_id:1,ability_path:"cleave"}
tag @s remove sgp.ability_damage_target
function sgp.kits:stats_collector/ability/mark_success {kit_id:1,ability_path:"cleave"}

assert score @s sgp.ability_success matches 1
assert data storage sgp.kits:stats kits_dict.910018.1.abilities.cleave{uses:1,successful_uses:1,affected_players:1}

function sgp.kits:stats_collector/ability/start {kit_id:5,ability_path:"bigger"}
scoreboard players set #damage_received_delta sgp.dummy 375
function sgp.kits:stats_collector/ability/tank_hit
scoreboard players set #damage_received_delta sgp.dummy 125
function sgp.kits:stats_collector/ability/tank_hit
scoreboard players reset #damage_received_delta sgp.dummy

assert score @s sgp.ability_kind matches 5
assert score @s sgp.ability_success matches 1
assert data storage sgp.kits:stats kits_dict.910018.5.abilities.bigger{uses:1,successful_uses:1,boosted_melee_damage:500}

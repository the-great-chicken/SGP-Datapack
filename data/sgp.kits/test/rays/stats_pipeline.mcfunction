#> sgp.kits:rays/stats_pipeline
# @dummy
# @environment sgp.ci:rays/stats_pipeline
#
# Real ray hits record damage_received per (victim, caster) and count each victim once per cast,
# even when a second caster hits the same victim in between; an invulnerable victim records nothing.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
# The second caster joins now so it is past join protection when it gets hit.
dummy RayOther spawn
gamemode survival RayOther
tp RayOther 20.5 88.0 14.5
await delay 61t
function sgp.ci:rays/prepare_damage
execute store result score #ci.stats.schema sgp.dummy run scoreboard players get #stats_schema_version sgp.dummy
execute store result score #ci.stats.paused sgp.dummy run scoreboard players get #stats_paused sgp.dummy
scoreboard players set #stats_schema_version sgp.dummy 7
scoreboard players set #stats_paused sgp.dummy 0
scoreboard players set @s sgp.id 930001
scoreboard players set @s sgp.kit_id 6
scoreboard players set RayNear sgp.id 930002
scoreboard players set RayNear sgp.kit_id 2
scoreboard players set RayFar sgp.id 930003
scoreboard players set RayFar sgp.kit_id 3
tag RayNear add sgp.in_game
tag RayFar add sgp.in_game
tag @s add sgp.in_game
scoreboard players set RayNear sgp.death_cause -1
data modify storage sgp.kits:stats kits_dict.930001.6.abilities.rays set value {uses:0,successful_uses:0,affected_players:0}
function sgp.kits:stats_collector/ability/start {kit_id:6,ability_path:"rays"}

# Two ticks: both victims sit on the south beam, 0.25 damage = 3 tenths per hit.
function sgp.ci:rays/update
function sgp.ci:rays/update
assert data storage sgp.kits:stats kits_dict.930002.2.damage_received.930001.6{102:6}
assert data storage sgp.kits:stats kits_dict.930003.3.damage_received.930001.6{102:6}
assert data storage sgp.kits:stats kits_dict.930001.6.abilities.rays{uses:1,successful_uses:1,affected_players:2}
assert score RayNear sgp.death_cause matches 102
assert entity @a[name=RayNear,tag=sgp.ability_affected.930001]
assert not score RayNear sgp.damage_taken matches -2147483648..2147483647

# A second caster hitting the same victims must not make the first caster count them again.
tp RayOther 8.5 88.0 12.5 0 0
scoreboard players set RayOther sgp.id 930004
scoreboard players set RayOther sgp.kit_id 6
scoreboard players set RayOther sgp.duration_ability 70
tag RayOther add sgp.in_game
execute as RayOther run function #bs.id:give_suid
data modify storage sgp.kits:stats kits_dict.930004.6.abilities.rays set value {uses:0,successful_uses:0,affected_players:0}
execute as RayOther at @s run function sgp.kits:abilities/rays/start
function sgp.ci:rays/update
execute as RayOther at @s run function sgp.kits:abilities/rays/tick
function sgp.ci:rays/update
execute as RayOther at @s run function sgp.kits:abilities/rays/tick
assert data storage sgp.kits:stats kits_dict.930001.6.abilities.rays{uses:1,successful_uses:1,affected_players:3}
assert data storage sgp.kits:stats kits_dict.930004.6.abilities.rays{uses:1,successful_uses:1,affected_players:3}
assert entity @a[name=RayNear,tag=sgp.ability_affected.930001]
assert entity @a[name=RayNear,tag=sgp.ability_affected.930004]

# A new cast clears the caster's tags and counts the victims again.
function sgp.kits:stats_collector/ability/start {kit_id:6,ability_path:"rays"}
assert not entity @a[name=RayNear,tag=sgp.ability_affected.930001]
assert entity @a[name=RayNear,tag=sgp.ability_affected.930004]
function sgp.ci:rays/update
assert data storage sgp.kits:stats kits_dict.930001.6.abilities.rays{uses:2,successful_uses:2,affected_players:6}

# An invulnerable victim makes /damage fail: no death cause, no statistics.
execute as RayOther at @s run function sgp.kits:abilities/rays/end
gamemode creative RayFar
scoreboard players set RayFar sgp.death_cause -1
function sgp.ci:rays/update
assert score RayFar sgp.death_cause matches -1
assert data storage sgp.kits:stats kits_dict.930003.3.damage_received.930001.6{102:15}

dummy RayOther leave
data remove storage sgp.kits:stats kits_dict.930001
data remove storage sgp.kits:stats kits_dict.930002
data remove storage sgp.kits:stats kits_dict.930003
data remove storage sgp.kits:stats kits_dict.930004
scoreboard players operation #stats_schema_version sgp.dummy = #ci.stats.schema sgp.dummy
scoreboard players operation #stats_paused sgp.dummy = #ci.stats.paused sgp.dummy

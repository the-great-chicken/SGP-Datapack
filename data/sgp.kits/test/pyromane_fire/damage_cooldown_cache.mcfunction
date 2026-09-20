#> sgp.kits:pyromane_fire/damage_cooldown_cache
# @dummy
# @environment sgp.ci:pyromane_fire/damage
#
# Overlapping fire markers skip only damage attempts that vanilla is guaranteed to reject.

function sgp.ci:pyromane_fire/damage_roster
await delay 61t
tp FireOwner ~0.5 ~1 ~0.5
tag FireOwner add sgp.in_game

# The first marker lands a real hit and arms the cache. The second marker sees the
# cache in the same update and does not retry the guaranteed-rejected hit.
summon marker ~0.5 ~1 ~0.5 {Tags:["sgp.ci.fire","sgp.marker"]}
summon marker ~0.5 ~1 ~0.5 {Tags:["sgp.ci.fire","sgp.marker"]}
scoreboard players set @e[tag=sgp.ci.fire,type=marker] sgp.timer 100
scoreboard players set @e[tag=sgp.ci.fire,type=marker] sgp.damage_owner 91001
function sgp.ci:pyromane_fire/tick
assert entity @a[name=FireOwner,nbt={Health:18.0f}]
assert entity @a[name=FireOwner,tag=sgp.tnt_fire_cached]
assert score FireOwner sgp.tnt_fire_cd matches 10
assert not entity @a[tag=sgp.current_damage_owner]

# One simulated production update consumes one cache tick without retrying damage.
function sgp.ci:pyromane_fire/tick
assert entity @a[name=FireOwner,nbt={Health:18.0f}]
assert entity @a[name=FireOwner,tag=sgp.tnt_fire_cached]
assert score FireOwner sgp.tnt_fire_cd matches 9

# A rejected /damage must never create a shortcut. Clear ours while vanilla's actual
# post-hit cooldown is still active, retry immediately, and verify it stays uncached.
execute as FireOwner run function sgp.kits:abilities/tnt/clear_fire_cooldown
function sgp.ci:pyromane_fire/tick
assert entity @a[name=FireOwner,nbt={Health:18.0f}]
assert not entity @a[name=FireOwner,tag=sgp.tnt_fire_cached]
assert score FireOwner sgp.tnt_fire_cd matches 0
assert not entity @a[tag=sgp.current_damage_owner]

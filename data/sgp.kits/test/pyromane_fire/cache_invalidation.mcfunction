#> sgp.kits:pyromane_fire/cache_invalidation
# @dummy
# @environment sgp.ci:pyromane_fire/cache_invalidation
#
# Damage that bypasses vanilla's cooldown can replace lastHurt/invulnerability state,
# so its existing death-cause callback must invalidate TNT fire's shortcut immediately.

function sgp.ci:pyromane_fire/damage_roster
await delay 61t
tp FireOwner ~0.5 ~1 ~0.5
tag FireOwner add sgp.in_game

summon marker ~0.5 ~1 ~0.5 {Tags:["sgp.ci.fire","sgp.marker"]}
scoreboard players set @e[tag=sgp.ci.fire,type=marker] sgp.timer 100
scoreboard players set @e[tag=sgp.ci.fire,type=marker] sgp.damage_owner 91001
function sgp.ci:pyromane_fire/tick
assert entity @a[name=FireOwner,nbt={Health:18.0f}]
assert entity @a[name=FireOwner,tag=sgp.tnt_fire_cached]
assert score FireOwner sgp.tnt_fire_cd matches 10

# ray is in minecraft:bypasses_cooldown. Its smaller hit replaces lastHurt below
# TNT fire's 2 damage, making the next fire hit immediately valid for the difference.
damage FireOwner 1 sgp.kits:ray
assert entity @a[name=FireOwner,nbt={Health:17.0f}]
assert not entity @a[name=FireOwner,tag=sgp.tnt_fire_cached]
assert score FireOwner sgp.tnt_fire_cd matches 0
function sgp.ci:pyromane_fire/tick
assert entity @a[name=FireOwner,nbt={Health:16.0f}]
assert entity @a[name=FireOwner,tag=sgp.tnt_fire_cached]
assert score FireOwner sgp.tnt_fire_cd matches 10

# Identity refresh represents a fresh player entity after reconnect; vanilla's
# transient hurt state is gone, so the datapack shortcut must be gone as well.
scoreboard players set FireOwner sgp.tnt_fire_cd 7
tag FireOwner add sgp.tnt_fire_cached
execute as FireOwner at @s run function sgp.kits:stats_collector/player_identity/capture
assert not entity @a[name=FireOwner,tag=sgp.tnt_fire_cached]
assert score FireOwner sgp.tnt_fire_cd matches 0

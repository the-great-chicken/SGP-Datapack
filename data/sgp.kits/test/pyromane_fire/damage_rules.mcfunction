#> sgp.kits:pyromane_fire/damage_rules
# @dummy
# @environment sgp.ci:pyromane_fire/damage
#
# Fire respects range and participation, attributes damage, and remains dangerous after its owner leaves.

function sgp.ci:pyromane_fire/damage_roster
await delay 61t
tag FireOwner add sgp.in_game
tag FireNear add sgp.in_game
tag FireEdge add sgp.in_game
tag FirePeace add sgp.in_game
tag FirePeace add sgp.peaceful
# Keep FireOutside outside the game despite standing inside the fire's radius.
summon marker ~0.5 ~1 ~0.5 {Tags:["sgp.ci.fire","sgp.marker"]}
scoreboard players set @e[tag=sgp.ci.fire,type=marker] sgp.timer 100
scoreboard players set @e[tag=sgp.ci.fire,type=marker] sgp.damage_owner 91001
function sgp.ci:pyromane_fire/tick
assert entity @a[name=FireOwner,nbt={Health:18.0f}]
assert entity @a[name=FireNear,nbt={Health:18.0f}]
assert entity @a[name=FireEdge,nbt={Health:18.0f}]
assert entity @a[name=FirePeace,nbt={Health:20.0f}]
assert entity @a[name=FireOutside,nbt={Health:20.0f}]
execute as FireNear on attacker run tag @s add sgp.ci.fire_attacker
assert entity @a[name=FireOwner,tag=sgp.ci.fire_attacker]
assert not entity @a[tag=sgp.current_damage_owner]
# An untouched player just beyond normal reach remains safe.
tag FireOutside add sgp.in_game
tp FireOutside ~4.1 ~1 ~0.5
function sgp.ci:pyromane_fire/tick
assert entity @a[name=FireOutside,nbt={Health:20.0f}]
# The enhanced fire reaches that player even after the caster disconnects.
dummy FireOwner leave
tag @e[tag=sgp.ci.fire,type=marker] add sgp.fire_explosion_bigger
tp FireOutside ~7 ~1 ~0.5
function sgp.ci:pyromane_fire/tick
assert entity @a[name=FireOutside,nbt={Health:18.0f}]
assert entity @a[name=FirePeace,nbt={Health:20.0f}]
assert not entity @a[tag=sgp.current_damage_owner]

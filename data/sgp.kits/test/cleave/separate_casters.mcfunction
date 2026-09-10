#> sgp.kits:cleave/separate_casters
# @dummy
# @environment sgp.ci:cleave/separate_casters
#
# Consecutive casters hit their own targets and each hit retains the correct attacker.

function sgp.ci:cleave/roster
await delay 61t
function sgp.ci:cleave/prepare
tp CleaveA ~10.5 ~1 ~13.5
tp CleaveB ~16.5 ~1 ~10.5 0 0
tp CleaveC ~16.5 ~1 ~13.5
function sgp.ci:cleave/cast
execute as CleaveB at @s run function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
assert entity @a[name=CleaveC,nbt={Health:15.0f}]
execute as CleaveA on attacker run tag @s add sgp.ci.first_sweep_owner
execute as CleaveC on attacker run tag @s add sgp.ci.second_sweep_owner
assert entity @s[tag=sgp.ci.first_sweep_owner,tag=!sgp.ci.second_sweep_owner]
assert entity @a[name=CleaveB,tag=sgp.ci.second_sweep_owner,tag=!sgp.ci.first_sweep_owner]

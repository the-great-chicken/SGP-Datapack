#> sgp.kits:tnt_detonation/linked_cleanup
# @dummy
# @environment sgp.ci:tnt_detonation/linked_cleanup
#
# Detonation removes its linked interaction even if another charge's interaction is closer.

function sgp.ci:tnt_detonation/fixture
execute positioned ~2.5 ~1 ~0.5 run tp @e[tag=sgp.ci.tnt_interaction_b,type=interaction] ~ ~ ~
execute positioned ~2.8 ~1 ~0.5 run tp @e[tag=sgp.ci.tnt_interaction_a,type=interaction] ~ ~ ~
function sgp.ci:tnt_detonation/detonate {target:a}
function sgp.ci:tnt_detonation/expect_fire {owner:98101,x:"~2.5"}
assert not entity @e[tag=sgp.ci.tnt_interaction_a,type=interaction]
assert entity @e[tag=sgp.ci.tnt_interaction_b,type=interaction]
assert entity @e[tag=sgp.ci.tnt_charge_b,nbt={fuse:100s},type=tnt]

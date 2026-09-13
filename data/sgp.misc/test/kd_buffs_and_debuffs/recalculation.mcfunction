#> sgp.misc:kd_buffs_and_debuffs/recalculation
# @dummy
#
# Recalculation replaces the KD modifier, clears it when ineligible, and preserves unrelated modifiers.

attribute @s minecraft:attack_damage base set 10
function sgp.ci:kd_buffs_and_debuffs/check {kills:0,deaths:100,kd:0,damage:1400}
function sgp.ci:kd_buffs_and_debuffs/check {kills:0,deaths:100,kd:0,damage:1400}
function sgp.ci:kd_buffs_and_debuffs/check {kills:250,deaths:100,kd:250,damage:800}
function sgp.ci:kd_buffs_and_debuffs/check {kills:9,deaths:2,kd:450,damage:1000}
attribute @s minecraft:attack_damage modifier add sgp.test:kd_extra 10 add_value
function sgp.ci:kd_buffs_and_debuffs/check {kills:0,deaths:100,kd:0,damage:2800}
function sgp.ci:kd_buffs_and_debuffs/check {kills:100,deaths:100,kd:100,damage:2000}

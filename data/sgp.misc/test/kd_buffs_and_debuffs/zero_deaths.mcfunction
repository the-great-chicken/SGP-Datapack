#> sgp.misc:kd_buffs_and_debuffs/zero_deaths
# @dummy
#
# Before the first death, use kills * 100 and retain the normal eligibility thresholds.

attribute @s minecraft:attack_damage base set 10
function sgp.ci:kd_buffs_and_debuffs/check {kills:0,deaths:0,kd:0,damage:1000}
function sgp.ci:kd_buffs_and_debuffs/check {kills:1,deaths:0,kd:100,damage:1000}
function sgp.ci:kd_buffs_and_debuffs/check {kills:9,deaths:0,kd:900,damage:1000}
function sgp.ci:kd_buffs_and_debuffs/check {kills:10,deaths:0,kd:1000,damage:500}
function sgp.ci:kd_buffs_and_debuffs/check {kills:10,deaths:1,kd:1000,damage:500}
function sgp.ci:kd_buffs_and_debuffs/check {kills:10,deaths:10,kd:100,damage:1000}

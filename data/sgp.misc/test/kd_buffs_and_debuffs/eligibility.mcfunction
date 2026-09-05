#> sgp.misc:kd_buffs_and_debuffs/eligibility
# @dummy
#
# Bonuses need ten deaths; penalties need ten kills. A neutral ratio gives neither.

attribute @s minecraft:attack_damage base set 10
function sgp.ci:kd_buffs_and_debuffs/check {kills:3,deaths:9,kd:33,damage:1000}
function sgp.ci:kd_buffs_and_debuffs/check {kills:3,deaths:10,kd:30,damage:1400}
function sgp.ci:kd_buffs_and_debuffs/check {kills:9,deaths:2,kd:450,damage:1000}
function sgp.ci:kd_buffs_and_debuffs/check {kills:10,deaths:2,kd:500,damage:500}
function sgp.ci:kd_buffs_and_debuffs/check {kills:10,deaths:10,kd:100,damage:1000}

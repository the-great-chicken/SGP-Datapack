#> sgp.cosmetics:kill_effects/unrelated_marker
# @dummy
# @environment sgp.ci:kill_effects/unrelated_marker
#
# An unrelated death-reaper marker cannot duplicate or relocate the effect and is left intact.

function sgp.ci:kill_effects/roster
await delay 61t
function sgp.ci:kill_effects/prepare
summon marker ~10.5 ~1 ~10.5 {CustomName:"death_reaper",Tags:["sgp.marker","sgp.ci.effect_marker"]}
tag @s add sgp.kill.anvil
function sgp.ci:kill_effects/record_attacker
function sgp.ci:kill_effects/dispatch
function sgp.ci:kill_effects/expect_anvil
assert entity @e[tag=sgp.ci.effect_marker,type=marker]

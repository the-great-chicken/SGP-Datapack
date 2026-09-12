#> sgp.cosmetics:kill_effects/attacker_selection
# @dummy
# @environment sgp.ci:kill_effects/attacker_selection
#
# The attacker's selected effect appears at the victim, regardless of the victim's selection.

function sgp.ci:kill_effects/roster
await delay 61t
function sgp.ci:kill_effects/prepare
tag @s add sgp.kill.anvil
tag EffectVictim add sgp.kill.firework
function sgp.ci:kill_effects/record_attacker
function sgp.ci:kill_effects/dispatch
function sgp.ci:kill_effects/expect_anvil

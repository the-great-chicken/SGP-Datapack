#> sgp.cosmetics:kill_effects/no_selection
# @dummy
# @environment sgp.ci:kill_effects/no_selection
#
# The victim's cosmetic is not used when the attacker has no kill effect selected.

function sgp.ci:kill_effects/roster
await delay 61t
function sgp.ci:kill_effects/prepare
tag EffectVictim add sgp.kill.anvil
function sgp.ci:kill_effects/record_attacker
function sgp.ci:kill_effects/dispatch
function sgp.ci:kill_effects/expect_none

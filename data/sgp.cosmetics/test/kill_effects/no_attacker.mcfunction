#> sgp.cosmetics:kill_effects/no_attacker
# @dummy
# @environment sgp.ci:kill_effects/no_attacker
#
# A victim with no attacker produces no kill effect, even with a cosmetic selected.

function sgp.ci:kill_effects/roster
await delay 61t
function sgp.ci:kill_effects/prepare
tag EffectVictim add sgp.kill.anvil
function sgp.ci:kill_effects/dispatch
function sgp.ci:kill_effects/expect_none

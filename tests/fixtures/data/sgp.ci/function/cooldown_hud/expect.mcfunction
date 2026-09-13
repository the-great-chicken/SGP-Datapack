#> sgp.ci:cooldown_hud/expect
# `{kit: kit id, frame: int}`
#
# Check the prepared overlay against the expected resource-pack frame and canonical kit appearance.

$data modify storage sgp:macro ci_hud_expected set from storage sgp:kits $(kit)
$data modify storage sgp:macro ci_hud_expected.frame set value $(frame)
function sgp.ci:cooldown_hud/assert_overlay with storage sgp:macro ci_hud_expected

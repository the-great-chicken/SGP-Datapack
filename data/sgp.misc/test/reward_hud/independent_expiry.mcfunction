#> sgp.misc:reward_hud/independent_expiry
# @dummy
# @environment sgp.ci:reward_hud/independent_expiry
#
# Later reward slots survive the first slot's expiry and expire on their own deadlines.

await score @s dah.actbar.UID matches 1..
function sgp.ci:reward_hud/fixture
function sgp.ci:reward_hud/scenarios/independent_expiry

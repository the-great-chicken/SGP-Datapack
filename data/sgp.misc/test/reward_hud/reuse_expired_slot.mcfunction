#> sgp.misc:reward_hud/reuse_expired_slot
# @dummy
# @environment sgp.ci:reward_hud/reuse_expired_slot
#
# A reward slot can be used again after expiry without resurrecting the old message.

await score @s dah.actbar.UID matches 1..
function sgp.ci:reward_hud/fixture
function sgp.ci:reward_hud/scenarios/reuse_expired_slot

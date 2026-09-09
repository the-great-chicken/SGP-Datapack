#> sgp.misc:reward_hud/clear_preserves_external
# @dummy
# @environment sgp.ci:reward_hud/clear_preserves_external
#
# Clearing the SGP HUD removes all reward slots while keeping another datapack's message.

await score @s dah.actbar.UID matches 1..
function sgp.ci:reward_hud/fixture
function sgp.ci:reward_hud/scenarios/clear_preserves_external

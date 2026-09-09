#> sgp.misc:reward_hud/player_isolation
# @dummy
# @environment sgp.ci:reward_hud/player_isolation
#
# Clearing one player's reward messages leaves another player's same-numbered slot active.

await score @s dah.actbar.UID matches 1..
function sgp.ci:reward_hud/fixture
dummy RewardPeer spawn
await score RewardPeer dah.actbar.UID matches 1..
execute as RewardPeer run function sgp.ci:reward_hud/fixture
function sgp.ci:reward_hud/scenarios/player_isolation

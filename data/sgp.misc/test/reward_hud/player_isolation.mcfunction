#> sgp.misc:reward_hud/player_isolation
# @dummy
# @environment sgp.ci:reward_hud/player_isolation
#
# Clearing one player's reward messages leaves another player's same-numbered slot active.

function sgp.ci:actionbar_mixer/fresh_registration
await score @s dah.actbar.UID matches 1..
function sgp.ci:reward_hud/fixture
dummy RewardPeer spawn
execute as RewardPeer run function sgp.ci:actionbar_mixer/fresh_registration
await score RewardPeer dah.actbar.UID matches 1..
execute as RewardPeer run function sgp.ci:reward_hud/fixture
function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"Mine"}',width:30}
execute as RewardPeer run function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"Peer"}',width:30}
function sgp.misc:actionbar/clear
function dah.actbar_mixer:get_data
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_1"}]
execute as RewardPeer run function dah.actbar_mixer:get_data
assert data storage dah:actbar data[0].content[{id:"sgp:reward_1",text:{text:"Peer"}}]
assert not data storage dah:actbar data[0].content[{text:{text:"Mine"}}]
assert score RewardPeer sgp.ab.reward_1 matches 80

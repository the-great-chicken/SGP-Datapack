#> sgp.ci:reward_hud/scenarios/player_isolation

function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"Mine"}',width:30}
execute as RewardPeer run function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"Peer"}',width:30}
function sgp.misc:actionbar/clear
function dah.actbar_mixer:get_data
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_1"}]
execute as RewardPeer run function dah.actbar_mixer:get_data
assert data storage dah:actbar data[0].content[{id:"sgp:reward_1",text:{text:"Peer"}}]
assert not data storage dah:actbar data[0].content[{text:{text:"Mine"}}]
assert score RewardPeer sgp.ab.reward_1 matches 80

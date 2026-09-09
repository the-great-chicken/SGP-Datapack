#> sgp.ci:reward_hud/scenarios/clear_preserves_external

data modify storage dah:actbar new set value {id:"other:message",order:200,text:{text:"External"}}
function dah.actbar_mixer:new/update_id
function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"First"}',width:30}
function sgp.misc:actionbar/reward {id:"sgp:reward_2",slot:2,text:'{text:"Second"}',width:30}
function sgp.misc:actionbar/reward {id:"sgp:reward_3",slot:3,text:'{text:"Third"}',width:30}
function sgp.misc:actionbar/clear
function dah.actbar_mixer:get_data
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_1"}]
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_2"}]
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_3"}]
assert data storage dah:actbar data[0].content[{id:"other:message",text:{text:"External"}}]
assert data storage dah:actbar data[0].content[{id:"dah_actbar:ROOT_RESET"}]
execute store result score #ci.reward.count sgp.dummy run data get storage dah:actbar data[0].content
assert score #ci.reward.count sgp.dummy matches 2

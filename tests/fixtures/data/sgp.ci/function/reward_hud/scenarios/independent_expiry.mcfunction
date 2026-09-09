#> sgp.ci:reward_hud/scenarios/independent_expiry

function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"First"}',width:30}
function sgp.ci:reward_hud/advance {ticks:30}
function sgp.misc:actionbar/reward {id:"sgp:reward_2",slot:2,text:'{text:"Second"}',width:30}
function sgp.misc:actionbar/reward {id:"sgp:reward_3",slot:3,text:'{text:"Third"}',width:30}
function sgp.ci:reward_hud/advance {ticks:50}
function dah.actbar_mixer:get_data
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_1"}]
assert data storage dah:actbar data[0].content[{id:"sgp:reward_2",text:{text:"Second"}}]
assert data storage dah:actbar data[0].content[{id:"sgp:reward_3",text:{text:"Third"}}]
function sgp.ci:reward_hud/advance {ticks:30}
function dah.actbar_mixer:get_data
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_2"}]
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_3"}]

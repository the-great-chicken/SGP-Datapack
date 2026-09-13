#> sgp.misc:reward_hud/refresh_deadline
# @dummy
# @environment sgp.ci:reward_hud/refresh_deadline
#
# Refreshing a slot replaces its text and gives the replacement a full lifetime.

function sgp.ci:actionbar_mixer/fresh_registration
await score @s dah.actbar.UID matches 1..
function sgp.ci:reward_hud/fixture
function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"Original"}',width:30}
function sgp.ci:reward_hud/advance {ticks:60}
function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"Replacement"}',width:30}
function sgp.ci:reward_hud/advance {ticks:20}
function dah.actbar_mixer:get_data
assert data storage dah:actbar data[0].content[{id:"sgp:reward_1",text:{text:"Replacement"}}]
assert not data storage dah:actbar data[0].content[{text:{text:"Original"}}]
execute store result score #ci.reward.count sgp.dummy run data get storage dah:actbar data[0].content
assert score #ci.reward.count sgp.dummy matches 2
function sgp.ci:reward_hud/advance {ticks:59}
function dah.actbar_mixer:get_data
assert data storage dah:actbar data[0].content[{id:"sgp:reward_1",text:{text:"Replacement"}}]
function sgp.ci:reward_hud/advance {ticks:1}
function dah.actbar_mixer:get_data
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_1"}]

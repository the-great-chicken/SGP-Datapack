#> sgp.misc:reward_hud/reuse_expired_slot
# @dummy
# @environment sgp.ci:reward_hud/reuse_expired_slot
#
# A reward slot can be used again after expiry without resurrecting the old message.

await score @s dah.actbar.UID matches 1..
function sgp.ci:reward_hud/fixture
function sgp.misc:actionbar/reward {id:"sgp:reward_2",slot:2,text:'{text:"Old"}',width:30}
function sgp.ci:reward_hud/advance {ticks:80}
function dah.actbar_mixer:get_data
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_2"}]
function sgp.misc:actionbar/reward {id:"sgp:reward_2",slot:2,text:'{text:"New"}',width:30}
function sgp.ci:reward_hud/advance {ticks:79}
function dah.actbar_mixer:get_data
assert data storage dah:actbar data[0].content[{id:"sgp:reward_2",text:{text:"New"}}]
assert not data storage dah:actbar data[0].content[{text:{text:"Old"}}]
function sgp.ci:reward_hud/advance {ticks:1}
function dah.actbar_mixer:get_data
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_2"}]

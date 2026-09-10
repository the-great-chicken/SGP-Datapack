#> sgp.misc:reward_hud/slot_order
# @dummy
# @environment sgp.ci:reward_hud/slot_order
#
# Rewards display in slot order even when they arrive out of order.

function sgp.ci:actionbar_mixer/fresh_registration
await score @s dah.actbar.UID matches 1..
function sgp.ci:reward_hud/fixture
function sgp.misc:actionbar/reward {id:"sgp:reward_3",slot:3,text:'{text:"Third"}',width:30}
function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"First"}',width:30}
function sgp.misc:actionbar/reward {id:"sgp:reward_2",slot:2,text:'{text:"Second"}',width:30}
function dah.actbar_mixer:get_data
data modify storage sgp.ci:reward_hud shown set from storage dah:actbar data[0].content[1].text
assert data storage sgp.ci:reward_hud shown{text:"First"}
data modify storage sgp.ci:reward_hud shown set from storage dah:actbar data[0].content[2].text
assert data storage sgp.ci:reward_hud shown{text:"Second"}
data modify storage sgp.ci:reward_hud shown set from storage dah:actbar data[0].content[3].text
assert data storage sgp.ci:reward_hud shown{text:"Third"}

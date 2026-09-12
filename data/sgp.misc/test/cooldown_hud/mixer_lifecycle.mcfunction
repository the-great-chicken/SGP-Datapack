#> sgp.misc:cooldown_hud/mixer_lifecycle
# @dummy
# @environment sgp.ci:mixer_lifecycle
#
# The real Mixer registers the player, replaces and expires rewards, and runs the SGP HUD override.

function sgp.ci:actionbar_mixer/fresh_registration
await score @s dah.actbar.UID matches 1..
function dah.actbar_mixer:get_data
assert data storage dah:actbar data[0].content[{id:"dah_actbar:ROOT_RESET"}]
scoreboard players set @s sgp.kit_id 2
function sgp.misc:actionbar/ability_cooldown_ready
function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"First"}',width:20}
function sgp.misc:actionbar/reward {id:"sgp:reward_1",slot:1,text:'{text:"Updated"}',width:30}
function dah.actbar_mixer:get_data
assert data storage dah:actbar data[0].content[{id:"sgp:reward_1",text:{text:"Updated"}}]
assert not data storage dah:actbar data[0].content[{text:{text:"First"}}]
execute store result score #ci.mixer.segments sgp.dummy run data get storage dah:actbar data[0].content
assert score #ci.mixer.segments sgp.dummy matches 2
# Poison the outputs so a missing or shadowed SGP override cannot pass.
data remove storage sgp:actionbar_hud overlay
data remove storage dah:actbar display_content
function dah.actbar_mixer:z_private/display/prepare
function sgp.ci:cooldown_hud/expect {kit:"archer",frame:20}
assert data storage dah:actbar display_content[{id:"sgp:reward_1",text:{text:"Updated"}}]
assert not data storage dah:actbar display_content[{id:"dah_actbar:ROOT_RESET"}]
scoreboard players set @s sgp.ab.reward_1 1
function sgp.misc:actionbar/tick
function dah.actbar_mixer:get_data
assert not data storage dah:actbar data[0].content[{id:"sgp:reward_1"}]
assert data storage dah:actbar data[0].content[{id:"dah_actbar:ROOT_RESET"}]
function sgp.misc:actionbar/ability_cooldown_clear
function dah.actbar_mixer:z_private/display/prepare
assert not data storage sgp:actionbar_hud overlay[0]
assert not data storage dah:actbar display_content[{id:"sgp:reward_1"}]

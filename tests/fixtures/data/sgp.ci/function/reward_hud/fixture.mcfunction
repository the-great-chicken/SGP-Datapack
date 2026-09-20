#> sgp.ci:reward_hud/fixture
# Reset SGP-owned actionbar output and verify no normal Mixer segments remain.

function sgp.misc:actionbar/clear
function dah.actbar_mixer:get_data
assert not data storage dah:actbar data[0].content[0]

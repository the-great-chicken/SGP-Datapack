#> sgp.ci:reward_hud/fixture
# Reset the actionbar output and verify the mixer starts from its canonical root component.

function sgp.misc:actionbar/clear
function dah.actbar_mixer:get_data
assert data storage dah:actbar data[0].content[{id:"dah_actbar:ROOT_RESET"}]

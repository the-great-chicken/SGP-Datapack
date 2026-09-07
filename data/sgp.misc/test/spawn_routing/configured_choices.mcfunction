#> sgp.misc:spawn_routing/configured_choices
# @dummy
# @environment sgp.ci:spawn_routing
#
# Repeated requests only use destinations from the supplied list, without mixing their coordinates and rotations.

function sgp.ci:spawn_routing/fixture
scoreboard players set #ci.spawn.samples sgp.dummy 12
function sgp.ci:spawn_routing/check_choice

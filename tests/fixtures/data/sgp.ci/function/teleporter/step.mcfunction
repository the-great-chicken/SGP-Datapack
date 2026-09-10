#> sgp.ci:teleporter/step
# Process every fixture portal through the production teleporter and recurse for the requested simulated ticks.

function sgp.misc:loop_as_entity/init {list_location:"sgp.ci:teleporter state.sources",command:"run function sgp.world:teleporter/run"}
scoreboard players remove #ci.portal.steps sgp.dummy 1
execute if score #ci.portal.steps sgp.dummy matches 1.. run function sgp.ci:teleporter/step

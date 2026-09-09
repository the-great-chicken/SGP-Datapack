#> sgp.ci:teleporter/step

function sgp.misc:loop_as_entity/init {list_location:"tests.teleporter.sources",command:"run function sgp.world:teleporter/run"}
scoreboard players remove #ci.portal.steps sgp.dummy 1
execute if score #ci.portal.steps sgp.dummy matches 1.. run function sgp.ci:teleporter/step

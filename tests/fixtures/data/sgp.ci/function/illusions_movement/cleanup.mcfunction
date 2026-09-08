#> sgp.ci:illusions_movement/cleanup

function sgp.ci:illusions_movement/clear
function sgp.ci:players/cleanup
# Let killed mannequins finish dying before their chunk can be saved and unloaded.
schedule function sgp.ci:illusions_movement/unload 21t replace

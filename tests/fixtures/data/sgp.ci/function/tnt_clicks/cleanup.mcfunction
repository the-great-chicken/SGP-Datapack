#> sgp.ci:tnt_clicks/cleanup
# Clear click-record scratch after removing the shared TNT interaction pairs.

function sgp.ci:tnt/interaction_pairs/clear
data remove storage sgp.ci:tnt_clicks attack
function sgp.ci:players/cleanup

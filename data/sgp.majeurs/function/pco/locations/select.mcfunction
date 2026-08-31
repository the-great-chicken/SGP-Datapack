#> sgp.majeurs:pco/locations/select
# Select the pinned location, or consume and rotate the first registered location.

execute if data storage sgp:data majeurs.pco.pinned_location \
    run return run function sgp.majeurs:pco/locations/activate with storage sgp:data majeurs.pco.pinned_location

data modify storage sgp:data majeurs.pco.active_location set from storage sgp:data majeurs.pco.locations[0]
function sgp.majeurs:pco/locations/activate with storage sgp:data majeurs.pco.active_location
data modify storage sgp:data majeurs.pco.locations append from storage sgp:data majeurs.pco.locations[0]
data remove storage sgp:data majeurs.pco.locations[0]

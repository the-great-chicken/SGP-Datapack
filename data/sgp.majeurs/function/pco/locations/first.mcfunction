#> sgp.majeurs:pco/locations/first
# `{id}`
# Put a registered location first in the automatic rotation.

$execute unless data storage sgp:data majeurs.pco.locations[{id:"$(id)"}] \
    run return run tellraw @s [{text:"Lieu PCO inconnu : ", color:red}, {text:"$(id)", color:gold}]

$data modify storage sgp:data majeurs.pco.location_buffer set from storage sgp:data majeurs.pco.locations[{id:"$(id)"}]
$data remove storage sgp:data majeurs.pco.locations[{id:"$(id)"}]
data modify storage sgp:data majeurs.pco.locations prepend from storage sgp:data majeurs.pco.location_buffer
data remove storage sgp:data majeurs.pco.location_buffer

$tellraw @s [{text:"Premier lieu de la prochaine rotation PCO : ", color:green}, {text:"$(id)", color:gold}]

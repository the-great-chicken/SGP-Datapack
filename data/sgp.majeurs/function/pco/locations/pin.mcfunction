#> sgp.majeurs:pco/locations/pin
# `{id}`
#
# Keep using one registered location until it is unpinned.

$execute unless data storage sgp:data majeurs.pco.locations[{id:"$(id)"}] \
    run return run tellraw @s [{text:"Lieu PCO inconnu : ", color:red}, {text:"$(id)", color:gold}]

$data modify storage sgp:data majeurs.pco.pinned_location set from storage sgp:data majeurs.pco.locations[{id:"$(id)"}]
$tellraw @s [{text:"Lieu PCO fixé pour les prochaines manches : ", color:green}, {text:"$(id)", color:gold}]

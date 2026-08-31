#> sgp.majeurs:pco/locations/activate
# `{id}`
# Freeze one registered location set as the active set for this round.

tag @e[tag=sgp.pco.active,type=marker] remove sgp.pco.active
tag @e[tag=sgp.pco.cage_open,type=marker] remove sgp.pco.cage_open

$tag @e[tag=sgp.pco.location_marker,nbt={data:{pco_location:"$(id)"}},type=marker] add sgp.pco.active
$data modify storage sgp:data majeurs.pco.active_location set value {id:"$(id)"}

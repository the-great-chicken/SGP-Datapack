#> sgp.majeurs:pco/locations/add
# `{id}`
# Add a permanently configured PCO location set to the end of the rotation.

$execute unless entity @e[tag=sgp.marker,tag=sgp.pco.location_marker,name="pco_cage_storage",nbt={data:{pco_location:"$(id)"}},type=marker] \
    run return run tellraw @s [{text:"Aucun lieu PCO configuré avec l'identifiant ",color:red},{text:"$(id)",color:gold},{text:".",color:red}]

$execute store result score #pco_registered_markers sgp.dummy \
    if entity @e[tag=sgp.pco.location_marker,nbt={data:{pco_location:"$(id)"}},type=marker]

$data remove storage sgp:data majeurs.pco.locations[{id:"$(id)"}]
$data modify storage sgp:data majeurs.pco.locations append value {id:"$(id)"}

$tellraw @s [{text:"Lieu PCO ajouté à la rotation : ", color:green}, {text:"$(id)", color:gold}, \
            {text:" (", color:gray}, {score:{name:"#pco_registered_markers",objective:"sgp.dummy"}, color:gray}, {text:" marqueurs).", color:gray}]

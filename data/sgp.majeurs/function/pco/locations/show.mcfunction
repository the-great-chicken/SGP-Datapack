#> sgp.majeurs:pco/locations/show
# Show the PCO location order and current selection to the caller.

tellraw @s [{text:"Lieux PCO (prochain en premier) : ", color:gold}, {storage:"sgp:data", nbt:"majeurs.pco.locations", color:gray}]
execute if data storage sgp:data majeurs.pco.pinned_location run tellraw @s [{text:"Lieu fixé : ", color:gold}, {storage:"sgp:data", nbt:"majeurs.pco.pinned_location.id", color:gray}]
execute unless data storage sgp:data majeurs.pco.pinned_location run tellraw @s [{text:"Lieu fixé : ", color:gold}, {text:"aucun", color:gray}]
execute if data storage sgp:data majeurs.pco.active_location run tellraw @s [{text:"Lieu actif : ", color:gold}, {storage:"sgp:data", nbt:"majeurs.pco.active_location.id", color:gray}]

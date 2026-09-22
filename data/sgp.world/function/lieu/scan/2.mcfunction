#> sgp.world:lieu/scan/2
# `{dx, dy, dz, lieu, lieu_propre, couleur, width, exclusion_box?}`: the registry snapshot of one marker.
# Shard 2 (generated): the membership pass of lieu/lieu_trouve, executed at the marker.
# Markers with an exclusion_box take scan_excluded/2; the others skip the exclusion probe
# instead of testing every contained player against the placeholder box.
execute if data storage sgp:data temp.lieu.list[0].data.exclusion_box run return run function sgp.world:lieu/scan_excluded/2 with storage sgp:data temp.lieu.list[0].data
$execute as @a[dx=$(dx), dy=$(dy), dz=$(dz)] run function sgp.world:lieu/main/2 {lieu_propre:"$(lieu_propre)", couleur:"$(couleur)", lieu:"$(lieu)", width:$(width)}
$execute as @a[scores={sgp.lieu_$(lieu)=2..}] unless entity @s[dx=$(dx), dy=$(dy), dz=$(dz)] run function sgp.world:lieu/leave {lieu:"$(lieu)"}

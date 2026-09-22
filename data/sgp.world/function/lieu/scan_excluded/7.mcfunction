#> sgp.world:lieu/scan_excluded/7
# `{dx, dy, dz, lieu, lieu_propre, couleur, width, exclusion_box}`: the registry snapshot of one marker.
# Shard 7 (generated): same logic as lieu/lieu_trouve for a marker with an exclusion box; the
# box comes from the snapshot and lieu/main/7 is this shard's private copy of lieu/main.
data modify storage sgp:macro lieu.current_boxes set from storage sgp:data temp.lieu.list[0].data.exclusion_box
$execute as @a[dx=$(dx), dy=$(dy), dz=$(dz)] \
    unless function sgp.world:lieu/check_exclusion_macro \
        run function sgp.world:lieu/main/7 {lieu_propre:"$(lieu_propre)", couleur:"$(couleur)", lieu:"$(lieu)", width:$(width)}
$execute as @a[dx=$(dx), dy=$(dy), dz=$(dz)] \
    if function sgp.world:lieu/check_exclusion_macro \
        run function sgp.world:lieu/leave {lieu:"$(lieu)"}
$execute as @a[scores={sgp.lieu_$(lieu)=2..}] unless entity @s[dx=$(dx), dy=$(dy), dz=$(dz)] run function sgp.world:lieu/leave {lieu:"$(lieu)"}

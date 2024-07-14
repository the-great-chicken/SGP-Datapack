$execute positioned ~$(x) ~$(y) ~$(z) run fill ~-1 ~ ~ ~-1 ~ ~$(dz) $(block)[facing=west] replace $(block_to_replace)
$execute positioned ~$(x) ~$(y) ~$(z) run fill ~ ~ ~-1 ~$(dx) ~ ~-1 $(block)[facing=north] replace $(block_to_replace)
$execute positioned ~$(x) ~$(y) ~$(z) run fill ~$(dx1) ~ ~ ~$(dx1) ~ ~$(dz) $(block)[facing=west] replace $(block_to_replace)
$execute positioned ~$(x) ~$(y) ~$(z) run fill ~ ~ ~$(dz1) ~$(dx) ~ ~$(dz1) $(block)[facing=north] replace $(block_to_replace)
return 1
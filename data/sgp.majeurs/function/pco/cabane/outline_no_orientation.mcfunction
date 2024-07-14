$execute positioned $(x) $(y) $(z) run fill ~-1 ~ ~ ~-1 ~ ~$(dz) $(block) replace $(block_to_replace)
$execute positioned $(x) $(y) $(z) run fill ~ ~ ~-1 ~$(dx) ~ ~-1 $(block) replace $(block_to_replace)
$execute positioned $(x) $(y) $(z) run fill ~$(dx1) ~ ~ ~$(dx1) ~ ~$(dz) $(block) replace $(block_to_replace)
$execute positioned $(x) $(y) $(z) run fill ~ ~ ~$(dz1) ~$(dx) ~ ~$(dz1) $(block) replace $(block_to_replace)
return 1
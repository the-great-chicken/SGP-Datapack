#> sgp.mineurs:bounty/select_wanted

$execute positioned $(base) as @a[tag=sgp.in_game,dx=$(dx),dz=$(dz),dy=$(dy),sort=random,limit=$(nbr_wanted)] run tag @s add sgp.wanted

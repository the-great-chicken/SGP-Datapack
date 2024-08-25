#> sgp.mineurs:bounty/select_wanted
#`base, dx, dz, dy, nbr_wanted`
#
# select players to be wanted

$execute positioned $(base) as @a[tag=sgp.in_game,dx=$(dx),dz=$(dz),dy=$(dy),sort=random,limit=$(nbr_wanted)] run tag @s add sgp.wanted

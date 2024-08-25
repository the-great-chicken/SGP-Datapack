#> sgp.mineurs:bounty/select_wanted

$execute as @a[tag=sgp.in_game,sort=random,limit=$(nbr_wanted)] run tag @s add sgp.wanted

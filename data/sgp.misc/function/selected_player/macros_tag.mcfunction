#> sgp.misc:selected_player/macros_tag
#`{nbr, tag}`
#
# add the given tag to a random subset of non-peaceful in-game players.

$execute as @a[sort=random,limit=$(nbr),tag=sgp.in_game,tag=!sgp.peaceful] run tag @s add $(tag)
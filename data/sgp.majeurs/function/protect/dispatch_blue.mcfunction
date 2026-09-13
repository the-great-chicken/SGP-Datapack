#> sgp.majeurs:protect/dispatch_blue
# `{count: positive integer}`
# Move half of the participant roster to blue, independently of spectators in the arena.

$team join sgp.bleue @a[tag=sgp.major_participant,sort=random,limit=$(count)]

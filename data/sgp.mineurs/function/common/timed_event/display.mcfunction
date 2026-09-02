#> sgp.mineurs:common/timed_event/display
# `{duration: int}`
#
# Move the XP display to the remaining time of the next event due to finish.

$experience set @a[tag=sgp.in_game] $(duration) levels
experience set @a[tag=sgp.in_game] 100000 points

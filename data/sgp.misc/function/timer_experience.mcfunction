#> sgp.misc:timer_experience
# `duration` is the duration of the game in seconds.
#
# to stop the timer, run the following command:
# scoreboard players set #second sgp.timer 0

$experience set @a[tag=sgp.in_game] $(duration) levels
$scoreboard players set #second sgp.timer $(duration)
experience set @a[tag=sgp.in_game] 100000 points
function sgp.misc:second
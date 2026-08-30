#> sgp.majeurs:config/hide_and_seek
# `{hour, minute, rounds}`

$scoreboard players set #hide_and_seek_hour sgp.dummy $(hour)
$scoreboard players set #hide_and_seek_minute sgp.dummy $(minute)
$scoreboard players set #hide_and_seek_max_rounds sgp.dummy $(rounds)

function sgp.majeurs:config/recompute_announcement {event:"hide_and_seek"}

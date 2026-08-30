#> sgp.majeurs:config/protect
# `{hour, minute, rounds}`

$scoreboard players set #protect_hour sgp.dummy $(hour)
$scoreboard players set #protect_minute sgp.dummy $(minute)
$scoreboard players set #protect_max_rounds sgp.dummy $(rounds)

function sgp.majeurs:config/recompute_announcement {event:"protect"}

#> sgp.majeurs:config/pco
# `{hour, minute, rounds}`

$scoreboard players set #pco_hour sgp.dummy $(hour)
$scoreboard players set #pco_minute sgp.dummy $(minute)
$scoreboard players set #pco_max_rounds sgp.dummy $(rounds)

function sgp.majeurs:config/recompute_announcement {event:"pco"}

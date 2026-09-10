#> sgp.ci:hider_teams/spawn
# `{number: positive int}`
#
# Recursively add numbered hider dummies until the requested fresh roster is complete.

execute if score #ci.hs.remaining sgp.dummy matches ..0 run return 0
$dummy HsGroup$(number) spawn
$tag HsGroup$(number) add sgp.ci.hider_actor
$team join sgp.hider HsGroup$(number)
scoreboard players remove #ci.hs.remaining sgp.dummy 1
$scoreboard players set #ci.hs.number sgp.dummy $(number)
execute store result storage sgp.ci:hider_teams spawn.number int 1 run scoreboard players add #ci.hs.number sgp.dummy 1
function sgp.ci:hider_teams/spawn with storage sgp.ci:hider_teams spawn

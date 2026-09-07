#> sgp.ci:hider_teams/cleanup

function #bs.schedule:cancel_all {with:{id:"hide_and_seek"}}
kill @e[tag=sgp.ci.hider_teams,type=marker]
function sgp.ci:players/cleanup
execute store result score #selector sgp.link_teams run data get storage sgp.ci:hider_teams previous_selector
data remove storage sgp.ci:hider_teams previous_selector

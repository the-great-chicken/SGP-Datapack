#> sgp.ci:hider_teams/populate
# `{count}`
# Build a fresh roster; the test's observing dummy is not part of it.

execute as @a[tag=sgp.ci.hider_actor] run dummy @s leave
function #bs.schedule:cancel_all {with:{id:"hide_and_seek"}}
kill @e[tag=sgp.ci.hider_teams,type=marker]
scoreboard players set #selector sgp.link_teams 1
$scoreboard players set #ci.hs.remaining sgp.dummy $(count)
data modify storage sgp.ci:hider_teams spawn set value {number:1}
function sgp.ci:hider_teams/spawn with storage sgp.ci:hider_teams spawn

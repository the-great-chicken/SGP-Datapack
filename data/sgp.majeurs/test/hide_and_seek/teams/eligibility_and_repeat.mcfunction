#> sgp.majeurs:hide_and_seek/teams/eligibility_and_repeat
# @dummy
# @environment sgp.ci:hider_teams
#
# Seekers and spectators are excluded, and calling selection again preserves existing group memberships.

function sgp.ci:hider_teams/populate {count:4}
team join sgp.seeker @s
tag @s add sgp.seeker
scoreboard players set @s sgp.link_teams 77
dummy HsSpectator spawn
tag HsSpectator add sgp.ci.hider_actor
tag HsSpectator add sgp.major_spectator
gamemode spectator HsSpectator
scoreboard players set HsSpectator sgp.link_teams 88
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:0,g4:1,g5:0}
assert score @s sgp.link_teams matches 77
assert score HsSpectator sgp.link_teams matches 88
assert not entity @s[tag=sgp.hider]
assert not entity @a[name=HsSpectator,tag=sgp.hider]
assert entity @s[team=sgp.seeker]
assert entity @a[name=HsSpectator,gamemode=spectator]

execute as @a[team=sgp.hider,tag=sgp.ci.hider_actor] run scoreboard players operation @s sgp.dummy = @s sgp.link_teams
function sgp.majeurs:hide_and_seek/teams/select_teams
execute as @a[team=sgp.hider,tag=sgp.ci.hider_actor] run assert score @s sgp.link_teams = @s sgp.dummy
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:0,g4:1,g5:0}

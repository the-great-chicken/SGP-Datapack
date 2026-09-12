#> sgp.ci:hider_reveal/expect_active
# The reveal fixture must remain an active roster through ordinary event ticks.

assert entity @s[tag=sgp.hider,tag=sgp.in_game,tag=sgp.major_participant,tag=!sgp.major_spectator,team=sgp.hider,gamemode=survival]
assert entity @a[name=RevealSeeker,tag=sgp.seeker,tag=sgp.in_game,tag=sgp.major_participant,tag=!sgp.major_spectator,team=sgp.seeker,gamemode=survival]

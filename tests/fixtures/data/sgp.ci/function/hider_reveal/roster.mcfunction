#> sgp.ci:hider_reveal/roster

fill ~ ~ ~ ~8 ~ ~8 stone
fill ~ ~1 ~ ~8 ~4 ~8 air
gamemode survival @s
tp @s ~1.5 ~1 ~1.5
tag @s add sgp.hider
tag @s add sgp.in_game
team join sgp.hider @s
dummy RevealSeeker spawn
gamemode survival RevealSeeker
tp RevealSeeker ~4.5 ~1 ~1.5
tag RevealSeeker add sgp.seeker
tag RevealSeeker add sgp.in_game
team join sgp.seeker RevealSeeker
dummy RevealIdle spawn
gamemode survival RevealIdle
tp RevealIdle ~6.5 ~1 ~1.5

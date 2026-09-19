#> sgp.bench:actors/remove_mixer_registration

execute store result storage sgp.bench:state mixer_uid int 1 run scoreboard players get @s dah.actbar.UID
function sgp.bench:actors/remove_mixer_uid with storage sgp.bench:state
data remove storage sgp.bench:state mixer_uid

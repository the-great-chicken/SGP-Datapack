#> sgp.majeurs:hide_and_seek/role/become_seeker
#
# This function is called when a player becomes a seeker.


function sgp.majeurs:hide_and_seek/reset_player

scoreboard players set @s sgp.timer 60

tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text":"Vous êtes devenue un chasseur !","color":"red"}]

function sgp.majeurs:hide_and_seek/role/set_seeker
function sgp.majeurs:hide_and_seek/timer/become_seeker
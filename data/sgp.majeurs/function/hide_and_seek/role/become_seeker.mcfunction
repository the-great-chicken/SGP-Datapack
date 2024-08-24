
function sgp.majeurs:hide_and_seek/reset_player

scoreboard players set @s sgp.timer 60

tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text":"Vous êtes devenue un chasseur !","color":"red"}]
tellraw @s [{"text":"Vous devez éliminer tous les Vollailles","color":"red"}]

function sgp.majeurs:hide_and_seek/role/set_seeker
function sgp.majeurs:hide_and_seek/timer/become_seeker
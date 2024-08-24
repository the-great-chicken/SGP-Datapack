
attribute @s generic.attack_damage modifier remove sgp.hider
attribute @s generic.movement_speed modifier remove sgp.hider
attribute @s generic.jump_strength modifier remove sgp.hider
team leave @s

tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text":"Vous êtes devenue un chasseur !","color":"red"}]
tellraw @s [{"text":"Vous devez éliminer tous les Vollailles","color":"red"}]

function sgp.majeurs:hide_and_seek/role/set_seeker
function sgp.majeurs:hide_and_seek/timer/become_seeker
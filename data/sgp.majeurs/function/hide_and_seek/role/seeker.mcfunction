function sgp.majeurs:hide_and_seek/role/set_seeker

tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text":"Vous êtes un chasseur !","color":"red"}]
tellraw @s [{"text":"Vous devez éliminer tous les Vollailles","color":"red"}]





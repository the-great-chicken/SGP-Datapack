#> sgp.majeurs:hide_and_seek/role/seeker
#
# This function is called when a player becomes a seeker.
tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text":"Vous êtes un chasseur !","color":"red"}]
function sgp.majeurs:hide_and_seek/role/set_seeker
say seeker




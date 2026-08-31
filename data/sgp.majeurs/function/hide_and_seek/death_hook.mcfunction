#> sgp.majeurs:hide_and_seek/death_hook
#
# Delay Cache-cache death handling until the player has respawned.

execute unless entity @s[predicate=sgp.majeurs:hide_and_seek/ongoing] run return 0
function sgp.majeurs:hide_and_seek/delay_death

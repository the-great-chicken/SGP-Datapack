# Returns 1 even if the slot was already empty.
execute unless entity @s[type=player] run return 0
function sgp.cosmetics:kill_effects/disable
return 1

# Returns 1 even if the slot was already empty.
execute unless entity @s[type=player] run return 0
function sgp.cosmetics:particles/disable_type
return 1

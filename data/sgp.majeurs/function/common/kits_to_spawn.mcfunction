#> sgp.majeurs:common/kits_to_spawn
# 
# When a player wants to go from the kits' room to the spawns',
# and a major event needs to change this behavior

# Protéger le Roi
execute if entity @a[predicate=sgp.majeurs:protect/ongoing] run function sgp.majeurs:protect/kits_to_spawn

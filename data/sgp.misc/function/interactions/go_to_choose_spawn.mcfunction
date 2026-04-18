#> sgp.misc:interactions/go_to_choose_spawn
# `{[x, y, z, yaw, pitch]: coordinates}`
#
# Tp to place to choose spawnpoint, except if confinement is running (then tp to a random confinement spawn)

execute if score #confines_secondes sgp.timer matches 1.. run return run tp @s @e[type=marker,tag=sgp.marker,name="Confinement",limit=1,sort=random] 

execute if entity @a[predicate=sgp.majeurs:event_in_progress] run return run function sgp.majeurs:common/kits_to_spawn

$tp @s $(x) $(y) $(z) $(yaw) $(pitch)
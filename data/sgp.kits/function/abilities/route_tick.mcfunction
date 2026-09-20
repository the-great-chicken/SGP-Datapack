#> sgp.kits:abilities/route_tick
#
# Kits who are not here have an ability without a duration
# Executed at and as the player

execute if entity @s[tag=sgp.alchimiste] run return run function sgp.kits:abilities/illusions/tick
execute if entity @s[tag=sgp.cancer] run return run function sgp.kits:abilities/bats/tick
execute if entity @s[tag=sgp.enderman] run return run function sgp.kits:abilities/assassinate/tick
execute if entity @s[tag=sgp.pigeon] anchored eyes run return run function sgp.kits:abilities/pecking/tick
execute if entity @s[tag=sgp.roi] run return run function sgp.kits:abilities/rays/tick
execute if entity @s[tag=sgp.tank] run return run function sgp.kits:abilities/bigger/tick
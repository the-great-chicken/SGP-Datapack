#> sgp.kits:unlocking/repeat_discovery
# @dummy
# @environment sgp.ci:unlocking/repeat_discovery
#
# Rediscovering a kit keeps progress and gives private feedback without repeating the celebration.

tag @s add sgp.in_game
scoreboard players set @s sgp.tank_found 0
function sgp.kits:unlocking/unlocking_kit {kit:"tank",kit_color:"gray",fw_color:8421504}
assert score @s sgp.tank_found matches 1
execute at @s run kill @e[distance=..2,type=firework_rocket]

# This observer did not receive the first announcement, so a second one is unambiguous.
dummy UnlockObserver spawn
tag UnlockObserver add sgp.in_game
function sgp.kits:unlocking/unlocking_kit {kit:"tank",kit_color:"gray",fw_color:8421504}
assert score @s sgp.tank_found matches 1
assert chat ".*déjà trouvé ce kit.*" @s
assert not chat ".*a trouvé le kit tank.*" UnlockObserver
assert not chat ".*déjà trouvé ce kit.*" UnlockObserver
execute at @s run assert not entity @e[distance=..2,type=firework_rocket]

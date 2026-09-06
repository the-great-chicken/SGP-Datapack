#> sgp.kits:unlocking/first_discovery
# @dummy
# @environment sgp.ci:unlocking/first_discovery
#
# A new discovery is saved and announced to participants without equipping the kit.

tag @s add sgp.in_game
scoreboard players reset @s sgp.tank_found
scoreboard players set @s sgp.kit_id 2
tag @s add sgp.archer
item replace entity @s weapon.mainhand with minecraft:diamond 7
dummy UnlockObserver spawn
tag UnlockObserver add sgp.in_game
dummy UnlockOutside spawn
function sgp.kits:unlocking/unlocking_kit {kit:"tank",kit_color:"gray",fw_color:8421504}
assert score @s sgp.tank_found matches 1
assert chat ".*a trouvé le kit tank.*" @s
assert chat ".*a trouvé le kit tank.*" UnlockObserver
assert not chat ".*a trouvé le kit tank.*" UnlockOutside
assert score @s sgp.kit_id matches 2
assert entity @s[tag=sgp.archer]
assert not entity @s[tag=sgp.tank_voulu]
function sgp.ci:kills_give/assert_count {item:"minecraft:diamond",count:7}
execute at @s store result score @s sgp.dummy if entity @e[distance=..2,type=firework_rocket]
assert score @s sgp.dummy matches 1

#> sgp.kits:unlocking/independent_progress
# @dummy
# @environment sgp.ci:unlocking/independent_progress
#
# Discoveries belong to a player and a kit; one discovery cannot unlock or suppress another.

scoreboard players set @s sgp.tank_found 0
scoreboard players set @s sgp.poseidon_found 0
dummy UnlockOther spawn
scoreboard players set UnlockOther sgp.tank_found 0
scoreboard players set UnlockOther sgp.poseidon_found 0
function sgp.kits:unlocking/unlocking_kit {kit:"tank",kit_color:"gray",fw_color:8421504}
assert score @s sgp.tank_found matches 1
assert score UnlockOther sgp.tank_found matches 0
assert score @s sgp.poseidon_found matches 0
execute as UnlockOther run function sgp.kits:unlocking/unlocking_kit {kit:"tank",kit_color:"gray",fw_color:8421504}
assert score UnlockOther sgp.tank_found matches 1
function sgp.kits:unlocking/unlocking_kit {kit:"poseidon",kit_color:"aqua",fw_color:65535}
assert score @s sgp.tank_found matches 1
assert score @s sgp.poseidon_found matches 1
assert score UnlockOther sgp.tank_found matches 1
assert score UnlockOther sgp.poseidon_found matches 0

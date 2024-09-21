#> sgp.kits:misc/random
# 
# Rolls a random number between 1 and 12, and runs the corresponding kit function
# to give it to the player

execute store result score #random_kit_roll sgp.dummy run random value 1..12

execute if score #random_kit_roll sgp.dummy matches 1 run return run function sgp.kits:misc/random_sub with storage sgp:kits combattant

execute if score #random_kit_roll sgp.dummy matches 2 run return run function sgp.kits:misc/random_sub with storage sgp:kits roi

execute if score #random_kit_roll sgp.dummy matches 3 run return run function sgp.kits:misc/random_sub with storage sgp:kits pigeon

execute if score #random_kit_roll sgp.dummy matches 4 run return run function sgp.kits:misc/random_sub with storage sgp:kits archer

execute if score #random_kit_roll sgp.dummy matches 5 run return run function sgp.kits:misc/random_sub with storage sgp:kits tank

execute if score #random_kit_roll sgp.dummy matches 6 run return run function sgp.kits:misc/random_sub with storage sgp:kits vindicateur

execute if score #random_kit_roll sgp.dummy matches 7 run return run function sgp.kits:misc/random_sub with storage sgp:kits eclaireur

execute if score #random_kit_roll sgp.dummy matches 8 run return run function sgp.kits:misc/random_sub with storage sgp:kits poseidon

execute if score #random_kit_roll sgp.dummy matches 9 run return run function sgp.kits:misc/random_sub with storage sgp:kits alchimiste

execute if score #random_kit_roll sgp.dummy matches 10 run return run function sgp.kits:misc/random_sub with storage sgp:kits enderman

execute if score #random_kit_roll sgp.dummy matches 11 run return run function sgp.kits:misc/random_sub with storage sgp:kits cancer

execute if score #random_kit_roll sgp.dummy matches 12 run return run function sgp.kits:misc/random_sub with storage sgp:kits pyromane

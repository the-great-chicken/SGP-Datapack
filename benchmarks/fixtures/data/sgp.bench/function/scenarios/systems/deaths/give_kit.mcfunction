#> sgp.bench:scenarios/systems/deaths/give_kit
# Same kit assignment as sgp.bench:scenarios/kits_idle/setup (sgp.bench.clock = local index % 12).
execute if score @s sgp.bench.clock matches 0 run function sgp.kits:give {kit:"pigeon"}
execute if score @s sgp.bench.clock matches 1 run function sgp.kits:give {kit:"combattant"}
execute if score @s sgp.bench.clock matches 2 run function sgp.kits:give {kit:"archer"}
execute if score @s sgp.bench.clock matches 3 run function sgp.kits:give {kit:"vindicateur"}
execute if score @s sgp.bench.clock matches 4 run function sgp.kits:give {kit:"pyromane"}
execute if score @s sgp.bench.clock matches 5 run function sgp.kits:give {kit:"tank"}
execute if score @s sgp.bench.clock matches 6 run function sgp.kits:give {kit:"roi"}
execute if score @s sgp.bench.clock matches 7 run function sgp.kits:give {kit:"eclaireur"}
execute if score @s sgp.bench.clock matches 8 run function sgp.kits:give {kit:"alchimiste"}
execute if score @s sgp.bench.clock matches 9 run function sgp.kits:give {kit:"enderman"}
execute if score @s sgp.bench.clock matches 10 run function sgp.kits:give {kit:"cancer"}
execute if score @s sgp.bench.clock matches 11 run function sgp.kits:give {kit:"poseidon"}
function sgp.kits:kit_tags/management

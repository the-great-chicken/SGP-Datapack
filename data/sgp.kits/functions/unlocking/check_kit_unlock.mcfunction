#> sgp.kits:unlocking/check_kit_unlock
# 
# Checks if someone unlocked a kit by triggering the corresponding objective

execute as @a[scores={sgp.roi_found=2}] run function sgp.kits:unlocking/unlocking_kit {kit:roi, kit_color:yellow, fw_color:"14602026"}
execute positioned 2485 214 2199 run function sgp.kits:unlocking/enable_kit_unlock {kit:roi}

execute as @a[scores={sgp.pigeon_found=2}] run function sgp.kits:unlocking/unlocking_kit {kit:pigeon, kit_color:dark_gray, fw_color:"4408131"}
execute positioned 2488 240 2195 run function sgp.kits:unlocking/enable_kit_unlock {kit:pigeon}

execute as @a[scores={sgp.tank_found=2}] run function sgp.kits:unlocking/unlocking_kit {kit:tank, kit_color:dark_blue, fw_color:"2437522"}
execute positioned 2477 206 2186 run function sgp.kits:unlocking/enable_kit_unlock {kit:tank}

execute as @a[scores={sgp.pyromane_found=2}] run function sgp.kits:unlocking/unlocking_kit {kit:pyromane, kit_color:gold, fw_color:"15435844"}
execute positioned 2427 206 2201 run function sgp.kits:unlocking/enable_kit_unlock {kit:pyromane}

execute as @a[scores={sgp.poseidon_found=2}] run function sgp.kits:unlocking/unlocking_kit {kit:poseidon, kit_color:dark_aqua, fw_color:"2651799"}
execute positioned 2480 206 2169 run function sgp.kits:unlocking/enable_kit_unlock {kit:poseidon}

execute as @a[scores={sgp.eclaireur_found=2}] run function sgp.kits:unlocking/unlocking_kit {kit:eclaireur, kit_color:aqua, fw_color:"6719955"}
execute positioned 2488 217 2141 run function sgp.kits:unlocking/enable_kit_unlock {kit:eclaireur}

execute as @a[scores={sgp.cancer_found=2}] run function sgp.kits:unlocking/unlocking_kit {kit:cancer, kit_color:dark_red, fw_color:"11743532"}
execute positioned 2441 231 2148 run function sgp.kits:unlocking/enable_kit_unlock {kit:cancer}

execute as @a[scores={sgp.enderman_found=2}] run function sgp.kits:unlocking/unlocking_kit {kit:enderman, kit_color:dark_purple, fw_color:"8073150"}
execute positioned 2453 240 2163 run function sgp.kits:unlocking/enable_kit_unlock {kit:enderman}

execute as @a[scores={sgp.alchimiste_found=2}] run function sgp.kits:unlocking/unlocking_kit {kit:alchimiste, kit_color:light_purple, fw_color:"12801229"}
execute positioned 2521 237 2149 run function sgp.kits:unlocking/enable_kit_unlock {kit:alchimiste}
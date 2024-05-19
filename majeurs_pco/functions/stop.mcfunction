# Supprime les cages
clone 2406 251 2181 2412 254 2183 2478 244 2138
clone 2413 251 2180 2416 254 2183 2497 239 2183
clone 2408 251 2189 2412 254 2192 2527 248 2141

removeglow @a
sudo Bafy78 useglow toggle
statuswarp pvp enabled
scoreboard players set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] death_reset_tags 1
scoreboard players set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] streak_en_cours 0
team empty Canard
team empty Oie
team empty Poule

# Supprime les portillons des cabanes
fill 2500 239 2182 2500 239 2180 minecraft:void_air
fill 2499 239 2179 2497 239 2179 minecraft:void_air
setblock 2484 244 2141 minecraft:void_air
setblock 2478 244 2141 minecraft:void_air
fill 2538 248 2144 2540 248 2144 minecraft:void_air
fill 2537 248 2141 2537 248 2143 minecraft:void_air
fill 2524 248 2144 2526 248 2144 minecraft:void_air

scoreboard players set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] death_reset_tags 1
execute as @a run trigger liberer_oies set 0
execute as @a run trigger liberer_canards set 0
execute as @a run trigger liberer_poules set 0
useglow
function lore:enable_npcs
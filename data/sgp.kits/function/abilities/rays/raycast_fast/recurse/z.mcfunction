#> sgp.kits:abilities/rays/raycast_fast/recurse/z

scoreboard players operation #raycast.lz bs.data += #raycast.dz bs.data
$execute positioned ~ ~ ~$(sz) run return run function sgp.kits:abilities/rays/raycast_fast/recurse/next with storage bs:data raycast

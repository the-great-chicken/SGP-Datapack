#> sgp.kits:abilities/rays/raycast_fast/recurse/x

scoreboard players operation #raycast.lx bs.data += #raycast.dx bs.data
$execute positioned ~$(sx) ~ ~ run return run function sgp.kits:abilities/rays/raycast_fast/recurse/next with storage bs:data raycast

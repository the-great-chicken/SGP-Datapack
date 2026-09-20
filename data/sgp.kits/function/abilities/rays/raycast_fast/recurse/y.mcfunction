#> sgp.kits:abilities/rays/raycast_fast/recurse/y

scoreboard players operation #raycast.ly bs.data += #raycast.dy bs.data
$execute positioned ~ ~$(sy) ~ run return run function sgp.kits:abilities/rays/raycast_fast/recurse/next with storage bs:data raycast

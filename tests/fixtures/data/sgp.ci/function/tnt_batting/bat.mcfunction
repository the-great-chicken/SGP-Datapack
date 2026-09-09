#> sgp.ci:tnt_batting/bat

# {yaw,pitch}: aim inherited from the hitter, independent of TNT rotation.
$execute rotated $(yaw) $(pitch) as @e[tag=sgp.ci.batted_tnt,type=tnt] run function sgp.kits:abilities/tnt/apply_kb

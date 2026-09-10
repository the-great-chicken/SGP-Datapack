#> sgp.ci:tnt_batting/bat
# `{yaw, pitch: degrees}`
#
# Apply production TNT knockback using the hitter's requested facing rather than the TNT's own rotation.

$execute rotated $(yaw) $(pitch) as @e[tag=sgp.ci.batted_tnt,type=tnt] run function sgp.kits:abilities/tnt/apply_kb

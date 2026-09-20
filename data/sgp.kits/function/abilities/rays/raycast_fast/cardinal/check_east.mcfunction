#> sgp.kits:abilities/rays/raycast_fast/cardinal/check_east
#
# @s intersects the corridor, so its hitbox reaches above and beside the beam line. The two boxes
# below, shifted one block down and one block sideways, prove it also reaches below and on the
# other side: the hitbox straddles the line on both transverse axes, i.e. the beam enters it.

execute if score #raycast.pe bs.data matches ..0 run return 0
execute positioned ~ ~-1 ~ unless entity @s[dx=15,dy=0,dz=0] run return 0
execute positioned ~ ~ ~-1 unless entity @s[dx=15,dy=0,dz=0] run return 0
function sgp.kits:abilities/rays/raycast_fast/cardinal/hit

#> sgp.kits:abilities/tnt/follow_interaction
#
# Executed as and at a TNT interaction.

scoreboard players operation $id.suid bs.in = @s bs.link.to
execute positioned ~-2 ~-2 ~-2 at @e[tag=sgp.tnt,dx=4,dy=4,dz=4,limit=1,predicate=bs.id:suid_equal,sort=arbitrary,type=tnt] run return run tp @s ~ ~ ~
execute at @e[tag=sgp.tnt,limit=1,predicate=bs.id:suid_equal,sort=arbitrary,type=tnt] run tp @s ~ ~ ~

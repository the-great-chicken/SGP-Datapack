#> sgp.ci:fangs_placement/cast
# `{count: positive int, x, y, z: coordinate, yaw: degrees}`
#
# Request one line of fangs through the production terrain placement routine.

$scoreboard players set #nbr_fangs sgp.dummy $(count)
$execute positioned $(x) $(y) $(z) rotated $(yaw) 0 run function sgp.kits:abilities/fangs/summon
tag @e[distance=..24,type=evoker_fangs] add sgp.ci.fang

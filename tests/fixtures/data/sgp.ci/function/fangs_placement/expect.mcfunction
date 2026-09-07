#> sgp.ci:fangs_placement/expect
# {x, y, z}
# Check a fang's location and that the current caster owns it.

$execute positioned $(x) $(y) $(z) run assert entity @e[tag=sgp.ci.fang,distance=..0.01,type=evoker_fangs]
$execute positioned $(x) $(y) $(z) run assert data entity @n[tag=sgp.ci.fang,distance=..0.01,type=evoker_fangs] Owner
$execute positioned $(x) $(y) $(z) run data modify storage sgp.ci:fangs_placement owner set from entity @n[tag=sgp.ci.fang,distance=..0.01,type=evoker_fangs] Owner
execute store success score #ci.fangs.owner sgp.dummy run data modify storage sgp.ci:fangs_placement owner set from entity @s UUID
assert score #ci.fangs.owner sgp.dummy matches 0

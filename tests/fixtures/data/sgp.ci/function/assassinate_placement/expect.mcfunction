#> sgp.ci:assassinate_placement/expect
# Check one landing pearl, one collision helper, and ownership by the assassin rather than the target.

execute store result score #ci.assassinate.pearls sgp.dummy if entity @e[tag=sgp.ci.assassinate,distance=..24,type=ender_pearl]
assert score #ci.assassinate.pearls sgp.dummy matches 1
execute store result score #ci.assassinate.endermites sgp.dummy if entity @e[tag=sgp.ci.assassinate,distance=..24,type=endermite]
assert score #ci.assassinate.endermites sgp.dummy matches 1
$execute positioned $(x) $(y) $(z) run assert entity @e[tag=sgp.ci.assassinate,distance=..0.01,type=ender_pearl]
assert data entity @e[tag=sgp.ci.assassinate,distance=..24,limit=1,type=ender_pearl] Owner
data modify storage sgp.ci:assassinate_placement owner set from entity @e[tag=sgp.ci.assassinate,distance=..24,limit=1,type=ender_pearl] Owner
execute store success score @s sgp.dummy run data modify storage sgp.ci:assassinate_placement owner set from entity @s UUID
assert score @s sgp.dummy matches 0

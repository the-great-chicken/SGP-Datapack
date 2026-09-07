#> sgp.ci:spawn_routing/expect_facing
# Compare yaw and pitch separately: NBT list matching does not enforce their order.

data modify storage sgp.ci:spawn_routing facing.yaw set from entity @s Rotation[0]
data modify storage sgp.ci:spawn_routing facing.pitch set from entity @s Rotation[1]
$assert data storage sgp.ci:spawn_routing facing{yaw:$(yaw)f,pitch:$(pitch)f}

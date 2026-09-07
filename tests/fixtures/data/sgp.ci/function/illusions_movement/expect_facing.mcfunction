#> sgp.ci:illusions_movement/expect_facing
# {direction, yaw, pitch}

$data modify storage sgp.ci:illusions_movement facing.yaw set from entity @n[tag=sgp.ci.illusion_first,tag=sgp.direction_$(direction),type=mannequin] Rotation[0]
$data modify storage sgp.ci:illusions_movement facing.pitch set from entity @n[tag=sgp.ci.illusion_first,tag=sgp.direction_$(direction),type=mannequin] Rotation[1]
$assert data storage sgp.ci:illusions_movement facing{yaw:$(yaw)f,pitch:$(pitch)f}

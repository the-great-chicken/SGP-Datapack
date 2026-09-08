#> sgp.ci:illusions_movement/expect_facing
# {direction, yaw, pitch}

$execute unless entity @e[tag=sgp.ci.illusion_first,tag=sgp.direction_$(direction),distance=..32,type=mannequin] run function sgp.ci:illusions_movement/inspect_decoy with storage sgp.ci:illusions_movement identities.first.$(direction)
$assert entity @e[tag=sgp.ci.illusion_first,tag=sgp.direction_$(direction),distance=..32,type=mannequin]
# Compare equivalent directions modulo one turn; Minecraft can retain yaw outside -180..180.
$execute store result score #ci.illusion.yaw sgp.dummy run data get entity @n[tag=sgp.ci.illusion_first,tag=sgp.direction_$(direction),type=mannequin] Rotation[0] 1000
$scoreboard players set #ci.illusion.expected_yaw sgp.dummy $(yaw)
scoreboard players set #ci.illusion.scale sgp.dummy 1000
scoreboard players operation #ci.illusion.expected_yaw sgp.dummy *= #ci.illusion.scale sgp.dummy
scoreboard players set #ci.illusion.turn sgp.dummy 360000
scoreboard players operation #ci.illusion.yaw sgp.dummy %= #ci.illusion.turn sgp.dummy
scoreboard players operation #ci.illusion.expected_yaw sgp.dummy %= #ci.illusion.turn sgp.dummy
assert score #ci.illusion.yaw sgp.dummy = #ci.illusion.expected_yaw sgp.dummy
$data modify storage sgp.ci:illusions_movement facing.pitch set from entity @n[tag=sgp.ci.illusion_first,tag=sgp.direction_$(direction),type=mannequin] Rotation[1]
$assert data storage sgp.ci:illusions_movement facing{pitch:$(pitch)f}

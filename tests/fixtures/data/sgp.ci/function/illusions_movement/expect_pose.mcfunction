#> sgp.ci:illusions_movement/expect_pose
# {group, pose}

$execute store result score #ci.illusion.count sgp.dummy if entity @e[tag=sgp.ci.illusion_$(group),nbt={pose:"$(pose)"},type=mannequin]
assert score #ci.illusion.count sgp.dummy matches 3

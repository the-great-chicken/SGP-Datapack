#> sgp.ci:illusions_movement/expect_pose
# {group, pose}

$execute store result score #ci.illusion.count sgp.dummy if entity @e[tag=sgp.ci.illusion_$(group),nbt={pose:"$(pose)"},type=mannequin]
execute if score #ci.illusion.count sgp.dummy matches 3 run return 1

# Include the update's inputs and all observed poses in a failed assertion.
$data modify storage sgp.ci:illusions_movement pose_failure set value {group:"$(group)",expected:"$(pose)",state:{poses:[],health:[],pose_score:-1,duration:-1,player_id:-1,center_link:-1}}
execute store result storage sgp.ci:illusions_movement pose_failure.state.pose_score int 1 run scoreboard players get #pose sgp.dummy
execute store result storage sgp.ci:illusions_movement pose_failure.state.duration int 1 run scoreboard players get @s sgp.duration_ability
execute store result storage sgp.ci:illusions_movement pose_failure.state.player_id int 1 run scoreboard players get @s bs.id
$execute store result storage sgp.ci:illusions_movement pose_failure.state.center_link int 1 run scoreboard players get @n[tag=sgp.ci.illusion_$(group),type=marker] bs.link.to
$execute as @e[tag=sgp.ci.illusion_$(group),type=mannequin] run data modify storage sgp.ci:illusions_movement pose_failure.state.poses append from entity @s pose
$execute as @e[tag=sgp.ci.illusion_$(group),type=mannequin] run data modify storage sgp.ci:illusions_movement pose_failure.state.health append from entity @s Health
function sgp.ci:illusions_movement/pose_failure
assert score #ci.illusion.count sgp.dummy matches 3

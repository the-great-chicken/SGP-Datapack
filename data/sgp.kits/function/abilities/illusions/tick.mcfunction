#> sgp.kits:abilities/illusions/tick
#
# Updates movement of illusions each tick

# This changes executor to the Marker, but keeps the position at the Player.
function #bs.link:as_children {run:"execute if entity @s[tag=sgp.illusion_center] run function #bs.position:get_relative_ata {scale:1000}"}

# Shift the execution position exactly to OUR Marker, then route to the mannequins
function #bs.link:as_children {run:"execute if entity @s[tag=sgp.illusion_center] positioned as @s run function #bs.link:as_parent {run:\"function sgp.kits:abilities/illusions/route\"}"}

scoreboard players operation $link.to bs.in = @s bs.id 

execute if entity @e[type=marker,tag=sgp.illusion_center,predicate=bs.link:link_equal] if predicate sgp.misc:is_sneaking run function #bs.link:as_children {run:"execute unless entity @s[tag=sgp.illusion_center] unless data entity @s {pose:\"crouching\"} run data modify entity @s pose set value \"crouching\""}
execute if entity @e[type=marker,tag=sgp.illusion_center,predicate=bs.link:link_equal] if predicate sgp.misc:is_swimming run function #bs.link:as_children {run:"execute unless entity @s[tag=sgp.illusion_center] unless data entity @s {pose:\"swimming\"} run data modify entity @s pose set value \"swimming\""}
execute if entity @e[type=marker,tag=sgp.illusion_center,predicate=bs.link:link_equal] unless predicate sgp.misc:is_sneaking run function #bs.link:as_children {run:"execute unless entity @s[tag=sgp.illusion_center] if data entity @s {pose:\"crouching\"} run data modify entity @s pose set value \"standing\""}
execute if entity @e[type=marker,tag=sgp.illusion_center,predicate=bs.link:link_equal] unless predicate sgp.misc:is_swimming run function #bs.link:as_children {run:"execute unless entity @s[tag=sgp.illusion_center] if data entity @s {pose:\"swimming\"} run data modify entity @s pose set value \"standing\""}

execute unless entity @e[type=marker,tag=sgp.illusion_center,predicate=bs.link:link_equal] if entity @s[team=sgp.Illusion] run team leave @s
#> sgp.kits:abilities/illusions/tick
#
# Updates movement of illusions each tick

# This changes executor to the Marker, but keeps the position at the Player.
function #bs.link:as_children {run:"execute if entity @s[tag=sgp.illusion_center] run function #bs.position:get_relative_ata {scale:1000}"}

# Shift the execution position exactly to OUR Marker, then route to the mannequins
function #bs.link:as_children {run:"execute if entity @s[tag=sgp.illusion_center] positioned as @s run function #bs.link:as_parent {run:\"function sgp.kits:abilities/illusions/route\"}"}

execute unless predicate bs.link:has_link if entity @s[team=sgp.Illusion] run team leave @s
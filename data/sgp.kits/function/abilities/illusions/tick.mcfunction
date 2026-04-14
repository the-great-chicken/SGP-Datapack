#> sgp.kits:abilities/illusions/tick
#
# Updates movement of illusions each tick

scoreboard players operation $link.to bs.in = @s bs.id 
execute unless entity @e[tag=sgp.illusion_center,predicate=bs.link:link_equal,type=marker,limit=1] run return run team leave @s

# This changes executor to the Marker, but keeps the position at the Player.
execute as @e[tag=sgp.illusion_center,predicate=bs.link:link_equal,type=marker,limit=1] run function sgp.kits:abilities/illusions/as_center

# Update the player's pose status to avoid checking multiple times
scoreboard players set #pose sgp.dummy 0
execute if predicate sgp.misc:is_sneaking run scoreboard players set #pose sgp.dummy 1
execute if predicate sgp.misc:is_swimming run scoreboard players set #pose sgp.dummy 2
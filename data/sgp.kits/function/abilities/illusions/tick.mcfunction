#> sgp.kits:abilities/illusions/tick
#
## Make mannequins imitate players
# As soon as https://github.com/mcbookshelf/bookshelf/issues/38 is implemented, make everything use bookshelf

execute if score @s sgp.duration_ability matches 1 run return run function sgp.kits:abilities/illusions/end

# Makes the bs.link:link_equal true for the player's children
scoreboard players operation $link.to bs.in = @s bs.id 

# This changes executor to the Marker, but keeps the position at the Player.
execute as @e[tag=sgp.illusion_center,predicate=bs.link:link_equal,type=marker,limit=1] run function sgp.kits:abilities/illusions/as_center

# Update the player's pose status to avoid checking multiple times
scoreboard players set #pose sgp.dummy 0
execute if predicate sgp.misc:is_sneaking run scoreboard players set #pose sgp.dummy 1
execute if predicate sgp.misc:is_swimming run scoreboard players set #pose sgp.dummy 2
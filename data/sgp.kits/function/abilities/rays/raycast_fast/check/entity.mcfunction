#> sgp.kits:abilities/rays/raycast_fast/check/entity
#
# Check one normal player using the hitbox dimensions cached from Bookshelf.

tag @s add bs.raycast.checked
execute unless entity @s[scores={bs.width=1..,bs.height=1..,bs.depth=1..}] run return 0

scoreboard players operation #w bs.ctx = @s bs.width
scoreboard players operation #h bs.ctx = @s bs.height
scoreboard players operation #d bs.ctx = @s bs.depth

scoreboard players operation #raycast.ry bs.data += #h bs.ctx
function sgp.kits:abilities/rays/raycast_fast/check/aabb
scoreboard players operation #raycast.ry bs.data -= #h bs.ctx

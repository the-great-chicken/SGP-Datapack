#> sgp.misc:on_left_click
#
# Makes the player's linked mannequins swing

scoreboard players add @s sgp.left_click_count 1
scoreboard players operation $link.to bs.in = @s bs.id
execute as @e[predicate=bs.link:link_equal,type=mannequin] run swing @s mainhand
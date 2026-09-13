#> sgp.diorama:left_click/on_left_click
#
# Makes the player's linked mannequins swing

# The enchant can trigger for a player who has never owned a mannequin. Allocate
# an id before touching Bookshelf's shared link input so an old owner's id cannot
# be reused when the source score is missing.
execute unless score @s bs.id matches 1.. run function #bs.id:give_suid
scoreboard players operation $link.to bs.in = @s bs.id
execute as @e[predicate=bs.link:link_equal,type=mannequin] run swing @s mainhand

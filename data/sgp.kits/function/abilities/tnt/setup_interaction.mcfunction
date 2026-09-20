#> sgp.kits:abilities/tnt/setup_interaction

# setup_interaction is entered as the freshly summoned interaction, but start keeps its new TNT tagged until this function finishes.
# Assign the TNT a Bookshelf SUID directly and copy it onto the hitbox.
execute at @s as @e[tag=sgp.tnt,tag=sgp.new,distance=..0.001,limit=1,sort=arbitrary,type=tnt] \
    unless predicate bs.id:has_suid \
        run function #bs.id:give_suid

execute at @s \
    run scoreboard players operation @s bs.link.to = @e[tag=sgp.tnt,tag=sgp.new,distance=..0.001,limit=1,sort=arbitrary,type=tnt] bs.id

function #bs.interaction:on_left_click { run: "function sgp.kits:abilities/tnt/on_hit", executor: source }
tag @s remove sgp.new

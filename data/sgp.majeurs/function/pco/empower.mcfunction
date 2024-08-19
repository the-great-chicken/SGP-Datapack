#> sgp.majeurs:pco/empower
#
# Give a strength effect to players who are looking at a player
# from the team they are supposed to catch

execute as @a[predicate=sgp.majeurs:pco/poule_qv_canard] \
    run effect give @s minecraft:strength 1 1

execute as @a[predicate=sgp.majeurs:pco/canard_qv_oie] \
    run effect give @s minecraft:strength 1 1

execute as @a[predicate=sgp.majeurs:pco/oie_qv_poule] \
    run effect give @s minecraft:strength 1 1
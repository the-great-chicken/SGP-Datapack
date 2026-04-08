#> sgp.kits:abilities/fangs/summon
#
# Recursively summons the fangs, snapping them on a block, in the direction the player is looking towards

execute if score #nbr_fangs sgp.dummy matches ..0 run return 1
execute unless predicate sgp.kits:is_context_inside_bounds run return fail

# Make sure that the first fang doesn't spawn IN a block
execute unless block ~ ~ ~ #bs.hitbox:can_pass_through \
        run return run execute positioned ~ ~1 ~ run function sgp.kits:abilities/fangs/summon

# Make sure that the first fang spawns ON a block
execute if block ~ ~-1 ~ #bs.hitbox:can_pass_through \
        run return run execute positioned ~ ~-1 ~ run function sgp.kits:abilities/fangs/summon

# Make it look better on bottom slabs
execute if block ~ ~-0.1 ~ #bs.block:has_state[type=bottom] \
        run summon evoker_fangs ~ ~-0.5 ~

execute unless block ~ ~-0.1 ~ #bs.block:has_state[type=bottom] \
        run summon evoker_fangs

scoreboard players remove #nbr_fangs sgp.dummy 1
execute positioned ^ ^ ^1 run function sgp.kits:abilities/fangs/summon
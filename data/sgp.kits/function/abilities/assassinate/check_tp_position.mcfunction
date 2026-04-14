#> sgp.kits:abilities/assassinate/check_tp_position
#
# Check the blocks behind the attacker, to determine the right position to tp to
# Summons an entity to collide the summoned enderpearl with (it's cooler than tp'ing) 

# Check A: If there is a solid block 1 block behind (at either feet OR head level), position 0.2 blocks behind instead.
# Case A1: Solid at feet level
execute unless block ^ ^ ^-1 #bs.hitbox:can_pass_through positioned ^ ^ ^-0.2 \
        run return run function sgp.kits:abilities/assassinate/summon_pearl

# Case A2: Clear at feet level, but solid at head level
execute unless block ^ ^1 ^-1 #bs.hitbox:can_pass_through positioned ^ ^ ^-0.2 \
        run return run function sgp.kits:abilities/assassinate/summon_pearl


# Check B: If 1 block behind is clear (both levels), but 2 blocks behind is a solid block (at either feet OR head level), position 1 block behind.
# Case B1: Solid at feet level 2 blocks behind
execute unless block ^ ^ ^-2 #bs.hitbox:can_pass_through positioned ^ ^ ^-1 \
        run return run function sgp.kits:abilities/assassinate/summon_pearl

# Case B2: Clear at feet level 2 blocks behind, but solid at head level 2 blocks behind
execute unless block ^ ^1 ^-2 #bs.hitbox:can_pass_through positioned ^ ^ ^-1 \
        run return run function sgp.kits:abilities/assassinate/summon_pearl


# Check C: If both 1 block and 2 blocks behind are clear (at both feet AND head levels), position 2 blocks behind.
execute positioned ^ ^ ^-2 run return run function sgp.kits:abilities/assassinate/summon_pearl
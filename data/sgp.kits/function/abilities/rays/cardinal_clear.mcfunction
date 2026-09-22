#> sgp.kits:abilities/rays/cardinal_clear
#
# Return success when every voxel crossed by a 16-block cardinal ray is pass-through.

execute if block ^ ^ ^0 #bs.hitbox:can_pass_through \
    if block ^ ^ ^1 #bs.hitbox:can_pass_through \
    if block ^ ^ ^2 #bs.hitbox:can_pass_through \
    if block ^ ^ ^3 #bs.hitbox:can_pass_through \
    if block ^ ^ ^4 #bs.hitbox:can_pass_through \
    if block ^ ^ ^5 #bs.hitbox:can_pass_through \
    if block ^ ^ ^6 #bs.hitbox:can_pass_through \
    if block ^ ^ ^7 #bs.hitbox:can_pass_through \
    if block ^ ^ ^8 #bs.hitbox:can_pass_through \
    if block ^ ^ ^9 #bs.hitbox:can_pass_through \
    if block ^ ^ ^10 #bs.hitbox:can_pass_through \
    if block ^ ^ ^11 #bs.hitbox:can_pass_through \
    if block ^ ^ ^12 #bs.hitbox:can_pass_through \
    if block ^ ^ ^13 #bs.hitbox:can_pass_through \
    if block ^ ^ ^14 #bs.hitbox:can_pass_through \
    if block ^ ^ ^15 #bs.hitbox:can_pass_through \
    if block ^ ^ ^16 #bs.hitbox:can_pass_through \
        run return 1

return 0

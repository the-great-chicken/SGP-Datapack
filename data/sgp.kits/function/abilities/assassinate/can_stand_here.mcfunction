#> sgp.kits:abilities/assassinate/can_stand_here
#
# Returns 1 if a player-sized vertical column is clear at the current position.
# The caller is responsible for choosing the candidate Y offset.

execute unless block ~ ~ ~ #bs.hitbox:can_pass_through run return 0
execute unless block ~ ~1 ~ #bs.hitbox:can_pass_through run return 0

return 1
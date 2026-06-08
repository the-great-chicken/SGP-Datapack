#> sgp.kits:can_give
# `{kit}`
#
# Returns 1 if @s may manually select this kit in the current context.
# Returns 0 otherwise.
# This function should not modify the player, except possibly sending a denial message.

$return run function sgp.kits:collection/$(kit)/can_give